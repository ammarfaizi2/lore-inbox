Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131729AbRCTGo0>; Tue, 20 Mar 2001 01:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCTGoR>; Tue, 20 Mar 2001 01:44:17 -0500
Received: from logger.gamma.ru ([194.186.254.23]:16908 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S131729AbRCTGoC>;
	Tue, 20 Mar 2001 01:44:02 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: Mounting ISO via Loop Devices
Date: 20 Mar 2001 09:35:30 +0300
Organization: Average
Message-ID: <996tni$eo8$1@pccross.average.org>
In-Reply-To: <Pine.LNX.4.30.0103171105270.19525-100000@biglinux.tccw.wku.edu>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0103171105270.19525-100000@biglinux.tccw.wku.edu>,
        "Brent D. Norris" <brent@biglinux.tccw.wku.edu> writes:
> On my redhat 7.1 machine I have been using the 2.4.0 redhat kernel and
> mounting ISO's to loop devices and it worked fine.  I upgraded to a 2.4.2
> kernel and now none of the ISO's will mount.  They all hang when the
> command is run.  Are there any other known occurences of this?

I can confirm that mount over loopback hangs on 2.4.2 (from kernel.org),
regardless of the filesystem type.

Eugene
