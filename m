Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEQHSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 03:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEQHSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 03:18:23 -0400
Received: from gw.enyo.de ([212.9.189.178]:23558 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261275AbTEQHSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 03:18:22 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Simon Kirby <sim@netnation.org>, linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
References: <8765pshpd4.fsf@deneb.enyo.de>
	<20030516222436.GA6620@netnation.com>
	<1053138910.7308.3.camel@rth.ninka.net>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, Simon Kirby
 <sim@netnation.org>,  linux-kernel@vger.kernel.org
Date: Sat, 17 May 2003 09:31:04 +0200
In-Reply-To: <1053138910.7308.3.camel@rth.ninka.net> (David S. Miller's
 message of "16 May 2003 19:35:10 -0700")
Message-ID: <87d6iit4g7.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Fri, 2003-05-16 at 15:24, Simon Kirby wrote:
>> I have been seeing this problem for over a year, and have had the same
>> problems you have with DoS attacks saturating the CPUs on our routers.
>
> Have a look at current kernels and see if they solve your problem.
> They undoubtedly should, and I consider this issue resolved.

The hash collision problem appears to be resolved, but not the more
general performance issues.  Or are there any kernels without a
routing cache?
