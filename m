Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSBOKbJ>; Fri, 15 Feb 2002 05:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292083AbSBOKaw>; Fri, 15 Feb 2002 05:30:52 -0500
Received: from vaak.stack.nl ([131.155.140.140]:29193 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S292082AbSBOKae>;
	Fri, 15 Feb 2002 05:30:34 -0500
Date: Fri, 15 Feb 2002 11:30:32 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.5.5-pre1: mounting NTFS partitions -t VFAT
Message-ID: <20020215112031.S68580-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Due to a recent change of filesystems, I found the following: 2.5.5-pre1
mounts my NTFS (win2k) partition as VFAT partition, if told to do so. The
kernel returns errors, but the mount is there. One write to the partition
was enough to destroy the entire NTFS partition.

Due to filesystem damage, I didn't test the behaviour of the VFAT driver
on other filesystems yet.

Kernel 2.4.17 also returns errors, but there the mount fails.

Will try to debug the problem myself this afternoon. Sounds like the VFAT
procedure ignores some errors.

Jos

