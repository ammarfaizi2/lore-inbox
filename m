Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVEMTUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVEMTUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVEMTRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:17:46 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:11020 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262490AbVEMTPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:15:07 -0400
Date: Fri, 13 May 2005 15:14:43 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: "Richard F. Rebel" <rrebel@whenu.com>
Cc: Andi Kleen <ak@muc.de>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513191443.GN27568@mail>
Mail-Followup-To: "Richard F. Rebel" <rrebel@whenu.com>,
	Andi Kleen <ak@muc.de>, Gabor MICSKO <gmicsko@szintezis.hu>,
	linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116009483.4689.803.camel@rebel.corp.whenu.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/05 02:38:03PM -0400, Richard F. Rebel wrote:
> On Fri, 2005-05-13 at 20:03 +0200, Andi Kleen wrote:
> > This is not a kernel problem, but a user space problem. The fix 
> > is to change the user space crypto code to need the same number of cache line
> > accesses on all keys. 
> > 
> > Disabling HT for this would the totally wrong approach, like throwing
> > out the baby with the bath water.
> > 
> > -Andi
> 
> Why?  It's certainly reasonable to disable it for the time being and
> even prudent to do so.

And what if you have more than one physical HT processor? AFAIK there's no
way to disable HT and still run SMP at the same time.

> 
> -- 
> Richard F. Rebel
> 
> cat /dev/null > `tty`

Jim.
