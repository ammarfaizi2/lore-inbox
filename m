Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWH1GAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWH1GAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWH1GAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:00:24 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:63898 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751377AbWH1GAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:00:24 -0400
Date: Mon, 28 Aug 2006 07:56:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wedgwood <cw@f00f.org>
cc: Paul Mackerras <paulus@samba.org>, Dong Feng <middle.fengdong@gmail.com>,
       ak@suse.de, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <20060828051409.GA17891@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.61.0608280754100.13393@yvahk01.tjqt.qr>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <17650.13915.413019.784343@cargo.ozlabs.ibm.com> <20060828051409.GA17891@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The i386 is older than some of the kernel hackers, and given that a
>modern kernel is pretty painful with less than say 16MB or RAM in
>practice

I have to concur. (Sure, you can't get a reasonable system to work on 16MB, 
but the kernel is fine with 5 megs of RAM. In fact, ancient i386 boxes 
usually do not have "big" things like SCSI, USB or Audio.)

>, I don't see that it would be all that terrible to drop
>support for ancient CPUs at some point (yes, I know some newer
>embedded (and similar) CPUs might be affected here too, but surely not
>that many that people really use --- and they could just use 2.4.x).



Jan Engelhardt
-- 
