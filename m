Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEQRPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEQRPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEQRPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:15:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51847 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261914AbUEQRPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:15:51 -0400
Message-ID: <40A8F339.8030908@pobox.com>
Date: Mon, 17 May 2004 13:15:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] kill off PC9800
References: <1084729840.10938.13.camel@mulgrave>	<20040516142123.2fd8611b.akpm@osdl.org>  <40A7DD0C.7010007@pobox.com> <1084743514.10765.22.camel@mulgrave>
In-Reply-To: <1084743514.10765.22.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sun, 2004-05-16 at 16:28, Jeff Garzik wrote:
> 
>>Although I like deleting things as much as the next guy :) I do have a 
>>question, to which I haven't come up with a good answer myself:
>>
>>Should PC9800 be excised en masse, or just toss the obviously broken or 
>>not-in-any-makefile/Kconfig pieces?
>>
>>The PC9800 net driver stuff still seems to build, and be sane.
> 
> 
> I haven't looked at the net stuff but if it's like the SCSI stuff, it's
> only usable in a pc9800.  The vanilla kernel currently has no way to
> select a pc9800 subarchitecture build.
> 
> This is a test of interest.  Since the pc9800 can't build the vanilla
> kernel, is anyone maintaining the out of tree pieces to allow it to
> build, and would they take on the job of maintaining it in-tree? if
> no-one's interested in maintaining the pc9800 subarchitecture
> components, it stands to reason that no-one is going to be compiling or
> running the net or scsi drivers, so there's no point keeping them
> hanging around.  Thus, if one piece goes, they all should.


Yeah, I suppose I agree, though I dislike removing it en masse for some 
reason.  No real technical reason, more just gut feeling...  The PC9800 
people spent a good long while working with Alan and others to get what 
little bits got merged into the kernel.

I suppose disappearing and not maintaining the code is the overriding 
factor here...

	Jeff



