Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUE1OHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUE1OHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUE1OHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:07:03 -0400
Received: from 217-162-68-113.dclient.hispeed.ch ([217.162.68.113]:51850 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S263182AbUE1OGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:06:53 -0400
Message-ID: <40B74779.40406@steudten.com>
Date: Fri, 28 May 2004 16:06:49 +0200
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: Kernel crash/ oops >= 2.6.5 with gcc 3.4.0 on alpha
References: <40B726C0.5030400@steudten.com> <20040528123758.GE19544@MAIL.13thfloor.at>
In-Reply-To: <20040528123758.GE19544@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgrade the binutils from 2.15.90 to 2.15.91, but the same
message appears:

gcc -Wp,-MD,fs/cifs/.cifsfs.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mno-fp-regs 
-ffixed-8 -msmall-data -mcpu=pca56 -Wa,-mev6 -O2 -fomit-frame-pointer 
-Wdeclaration-after-statement   -DMODULE -DKBUILD_BASENAME=cifsfs -DKBUILD_MODNAME=cifs -c -o 
fs/cifs/.tmp_cifsfs.o fs/cifs/cifsfs.c
{standard input}: Assembler messages:
{standard input}:7: Warning: setting incorrect section attributes for .got



> hmm, did you update the binutils too?
> (if not, I'd try that)
> 

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?


