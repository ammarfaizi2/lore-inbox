Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFNHeN>; Thu, 14 Jun 2001 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbRFNHeD>; Thu, 14 Jun 2001 03:34:03 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:52488 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S261296AbRFNHdt>; Thu, 14 Jun 2001 03:33:49 -0400
Date: Thu, 14 Jun 2001 13:22:20 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg-directory size
In-Reply-To: <Pine.LNX.4.10.10106081152440.21471-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106141300430.21100-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When we create lot of files and directories under a directory the size of
the directory changes after aparticular limit. I could find that if the
size of directory is 4096 it can create 341 files(size of qstr structure
for each file is 12 bytes,so 4096/12=341.xx) before it changes to 8192. 
Please tell me where in the code does this directory size changes. Is it
in VFS level or in  the file system level? Please tell me this which would
be of great use to me.

Thanks in advance,
With Regards,
Sathish.J 

