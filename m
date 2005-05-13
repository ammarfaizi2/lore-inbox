Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVEMUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVEMUen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVEMUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:33:46 -0400
Received: from orb.pobox.com ([207.8.226.5]:27585 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262530AbVEMUSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:18:46 -0400
Date: Fri, 13 May 2005 13:18:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Richard F. Rebel" <rrebel@whenu.com>, Andi Kleen <ak@muc.de>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513201840.GB7436@ip68-225-251-162.oc.oc.cox.net>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513191443.GN27568@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513191443.GN27568@mail>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:14:43PM -0400, Jim Crilly wrote:
> And what if you have more than one physical HT processor? AFAIK there's no
> way to disable HT and still run SMP at the same time.

Actually, there is; read my post earlier in this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111598859708620&w=2

To elaborate on the "check dmesg" part of that e-mail:

After you reboot with "maxcpus=2" (or however many physical CPU's you
have), you need to make sure you have messages like this, which indicate
that it really worked:

WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.

(and so on, if you have more than 2 CPU's)

-Barry K. Nathan <barryn@pobox.com>

