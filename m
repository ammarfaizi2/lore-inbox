Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRLPA1E>; Sat, 15 Dec 2001 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284160AbRLPA0z>; Sat, 15 Dec 2001 19:26:55 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:43254 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S284156AbRLPA0j>; Sat, 15 Dec 2001 19:26:39 -0500
Message-ID: <00c801c185c8$466ebb60$5900a8c0@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: use shmfs
Date: Sat, 15 Dec 2001 16:26:15 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Currently I'm using shmfs as a volatile storage. I am using Monta Vista's
kernel (2.4.2). I added the following line in /etc/fstab:

tmpfs                   /dev/shm                shm     defaults        0 0

# df /dev/shm
Filesystem           1k-blocks      Used Available Use% Mounted on
tmpfs                        0         0         0   -  /dev/shm

the "0" number of blocks seems fishy.

I cannot write to the filesystem. write returns EINVAL. I can create an
empty file, however.

What should I do to make it work? Thanks.

By the way, I know tmpfs is a replacement of shmfs, but it's not in the
2.4.2 kernel I am using (can't find in config). Is it in any newer kernels
(especially 2.4.9)? Is it stable enough?

Thanks

