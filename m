Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVCCAOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVCCAOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCCALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:11:16 -0500
Received: from tim.rpsys.net ([194.106.48.114]:45036 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261320AbVCCAHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:07:38 -0500
Message-ID: <08b301c51f84$fecae0e0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Subject: Re: Kernel release numbering
Date: Thu, 3 Mar 2005 00:06:56 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds:
> Namely that we could adopt the even/odd numbering scheme that we used
> to do on a minor number basis, and instead of dropping it entirely like
> we did, we could have just moved it to the release number, as an 
> indication
> of what was the intent of the release.

How about taking the idea a bit further and have two active versions. Eg: 
now 2.6.11 is out, new changes go into a 2.6.13 series. Any changes to make 
2.6.11 (more :) stable go into a 2.6.12 series which is 
stability/security/whatever improvements rather than devel work.

This way you can shorten the length of the time the odd series spends in -rc 
and can spend more time accepting patches rather than having long periods 
where developers queue them. Distributors are encouraged to use the even 
numbers including the even -rc versions and to give feedback as to what 
stability/whatever patches need adding to the even series to keep them 
happy.

Just an idea...

Regards,

Richard




