Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbUJ1SOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUJ1SOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUJ1SOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:14:36 -0400
Received: from main.gmane.org ([80.91.229.2]:26302 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262868AbUJ1SOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:14:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: bkbits - "@" question
Date: Thu, 28 Oct 2004 20:13:49 +0200
Message-ID: <yw1xpt32lnhe.fsf@inprovide.com>
References: <200410230426.i9N4Qd9k004757@work.bitmover.com> <20041028174838.GA794@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 154.80-202-166.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:05oGlgqREFTJk3PZq8k5Fwhtfyc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Frazer <mark@mjfrazer.org> writes:

> Larry McVoy <lm@bitmover.com> [04/10/23 01:31]:
>> The web pages on bkbits.net contain email addresses.  This is probably
>> about a 4 year too late question but would it help reduce spam if we
>> did something like  s/@/ (at) / for all those addresses?
>
> Hi Larry:  I've used this for a while to add email addresses to my web
> pages and I get almost no spam any more, < 10 per month!
>
> [mjfrazer@pacific depictII]$ html-encode mark@mjfrazer.rog
> &#109;&#97;&#114;&#107;&#64;&#109;&#106;&#102;&#114;&#97;&#122;&#101;&#114;&#46;&#114;&#111;&#103;
> [mjfrazer@pacific depictII]$ 
>
> I've attached the source.

Why not just perl -pe 's/(.)/"&#".ord($1).";"/eg;' ?

-- 
Måns Rullgård
mru@inprovide.com

