Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270143AbRHGOtj>; Tue, 7 Aug 2001 10:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270066AbRHGOta>; Tue, 7 Aug 2001 10:49:30 -0400
Received: from ci176196-a.grnvle1.sc.home.com ([24.4.120.228]:55568 "HELO
	cavuaviation.com") by vger.kernel.org with SMTP id <S270143AbRHGOtX>;
	Tue, 7 Aug 2001 10:49:23 -0400
Subject: Re: encrypted swap
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: lk <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20010807103637.00a88b60@pop.prism.gatech.edu>
In-Reply-To: <5.1.0.14.2.20010807103637.00a88b60@pop.prism.gatech.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 07 Aug 2001 10:48:44 -0400
Message-Id: <997195727.7775.9.camel@rhino>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a should-if debate, in my opinion. That is, not if you can do it, 
> but should you. Has anybody thought of the performance hit that you would 
> take encrypting your swap?
> 
> David Maynor

Insignificant I'd think.  Disk is already thousands of times slower than
RAM.  Ever needing to swap at all is a huge penalty - if the crypto adds
10% system access time to that (a long time for RAM and hardly anything
for disk), who'd notice?

Billy




