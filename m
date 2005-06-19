Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVFSAX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVFSAX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 20:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVFSAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 20:23:57 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:21442 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262212AbVFSAXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 20:23:31 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@muc.de>
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work II + PATCH
Date: Sun, 19 Jun 2005 01:23:50 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506181452.52921.s0348365@sms.ed.ac.uk> <20050618235229.GA35248@muc.de>
In-Reply-To: <20050618235229.GA35248@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506190123.50316.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Sunday 19 Jun 2005 00:52, Andi Kleen wrote:
[snip]
>
> It's a bit of a shot into the dark, but could you test if the following
> patch helps?  The A64 is quite aggressive in reordering instructions and it
>  might be breaking __delay() and cause it to return early.
>

Firstly, I apologise in the delay getting back to you.

I tried the patch, but the machine still hung in the same way with the options 
apic apic=verbose (I don't know if the first "apic" is required, or whether 
this is an invalid combination of parameters, but it hung in the same way).

> If not I would check what a failing case and a working case output for
>
> Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
>
> Does the failing kernel output something different here?

I'll get back to you about this, but see my other email (a successfully booted 
apic=debug machine). Thanks for investigating this.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
