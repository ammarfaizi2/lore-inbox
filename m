Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132831AbRDUTMn>; Sat, 21 Apr 2001 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRDUTMd>; Sat, 21 Apr 2001 15:12:33 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:49877 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132831AbRDUTMX>; Sat, 21 Apr 2001 15:12:23 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200104211910.UAA22531@mauve.demon.co.uk>
Subject: Re: Idea: Encryption plugin architecture for file-systems
To: nagytam@rerecognition.com (Tamas Nagy)
Date: Sat, 21 Apr 2001 20:10:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-kernel@vger.linux.org.btinternet.com
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> from "Tamas Nagy" at Apr 21, 2001 08:52:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hello,
ftp://www.kerneli.org/pub/linux/kerneli/

For idea encryption, you just use
losetup -e idea /dev/loop0 /filesystem
Password: whatever

mke2fs /dev/loop0 
mount /dev/loop0

