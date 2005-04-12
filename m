Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVDLUlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVDLUlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVDLUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:40:17 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:24566 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262594AbVDLTW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:22:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=V62lsnInCUkCsZpcCLRQvyJMSBnR9QvGFNY5wUV7+jYyHxSGjPjwcSywDfq3ksyl0go03CmsybZPzOY86OjE6B6as0bkbyzDqoSVdzR1UTL+hQvb9GCcBPTd5ER4UG1ZPc1fLxDqNaZ+bauTEWf++a1fB8FNO+6HQdukgNChgWc=
Message-ID: <4ae3c1405041212223ee0609e@mail.gmail.com>
Date: Tue, 12 Apr 2005 15:22:56 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS2 question, help, pls!
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have very very fast network and is testing NFS2 over this kind of
network. I noticed that for standard work like read/write a large
file,  compile kernels, the performance of NFS2 is good. But if I try
to decompress kernel tar file. The standard ext2 takes 28s while NFS2
takes 81s. Also, if I remove the kernel source code tree, ext2 takes
19s but NFS2 takes 44s.

Why?  (You can assume that network is very fast. )  Is there any
improvements in NFS3/4 on this issue? If so, how?

Many thanks in advance for your kind help!

xin
