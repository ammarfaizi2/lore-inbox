Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbSLLVMv>; Thu, 12 Dec 2002 16:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbSLLVMv>; Thu, 12 Dec 2002 16:12:51 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:55275 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S267510AbSLLVMu>; Thu, 12 Dec 2002 16:12:50 -0500
Message-ID: <3DF8FD59.9030100@drugphish.ch>
Date: Thu, 12 Dec 2002 22:19:21 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/8): export sys_wait4.
References: <20021212142645.A2998@devserv.devel.redhat.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
>>+EXPORT_SYMBOL(sys_wait4);
> 
> Martin, hold on just a second. Last I checked, sys_wait4 was
> used ONLY by a moronic code in ipvs, _and_ there was a comment
> by the author above it "we are too lazy to do it properly".
> Do you have a better reason to export it?

Guess I'm the malefactor this time since I've sent this patch to Martin 
after some email exchanges with a guy that wanted LVS to work on a s390. 
I reckon I will fix the said moronic code to use a syscall wrapper for 
sys_wait4() so we don't step on anyone's toes.

Regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

