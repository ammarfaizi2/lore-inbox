Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268616AbRG3OPu>; Mon, 30 Jul 2001 10:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRG3OPl>; Mon, 30 Jul 2001 10:15:41 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:30598 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S268612AbRG3OPb>; Mon, 30 Jul 2001 10:15:31 -0400
Date: Mon, 30 Jul 2001 15:15:38 +0100
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Kurt Garloff <garloff@suse.de>, Daniela Engert <dani@ngrt.de>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010730151538.A5600@debian>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kurt Garloff <garloff@suse.de>, Daniela Engert <dani@ngrt.de>
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl> <20010730125012Z268576-720+7896@vger.kernel.org> <20010730154458.C4859@pckurt.casa-etp.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010730154458.C4859@pckurt.casa-etp.nl>
User-Agent: Mutt/1.3.18i
From: Michael <leahcim@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > On Sun, 29 Jul 2001 22:28:30 +0200, Kurt Garloff wrote:
> > [54:6]=Probe Next Tag State T1	0=disable   1=enable
> 
> Main suspect. (Should be 0)

That's set in my stable kt133a system.
 
> > [54:0]=Fast Write-to-Read	0=disable   1=enable
> 
> Third candidate. (Should be 0)

as is this one.
 
> > [68:2]=Burst Refresh(4 times)	0=disable   1=enable
> 
> Fourth candidate (Should be 0?)

I set this one yesterday to see if it would trigger the problem, it
didn't :o/ Same with a few differences between my system and 0x6b, which
didn't either.

Out of curiosity, where are you getting the 'should be 0/1' details from?
-- 
Michael.
 
