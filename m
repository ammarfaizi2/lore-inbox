Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVALUBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVALUBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVALUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:00:10 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:1229 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261331AbVALTup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:50:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Jan 2005 11:50:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501091830120.2373@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501121148330.28987@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0501091946020.3620-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501091713300.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501091830120.2373@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Linus Torvalds wrote:

> On Sun, 9 Jan 2005, Linus Torvalds wrote:
> > 
> > Since you guys stupidly showed interest, here's a very first-order
> > approximation of filling the pipe from some other source.
> 
> Here's a somewhat fixed and tested version, which actually does something 
> on x86.

Question. How do you think to splice() skb pages, or any other non page-based
format?



- Davide

