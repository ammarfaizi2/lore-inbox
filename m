Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbSJMMrJ>; Sun, 13 Oct 2002 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSJMMrJ>; Sun, 13 Oct 2002 08:47:09 -0400
Received: from [203.117.131.12] ([203.117.131.12]:45466 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261684AbSJMMrH>; Sun, 13 Oct 2002 08:47:07 -0400
Message-ID: <3DA96CA3.80000@metaparadigm.com>
Date: Sun, 13 Oct 2002 20:52:51 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: venom@sns.it
Cc: jw schultz <jw@pegasys.ws>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
References: <Pine.LNX.4.43.0210131354020.9392-100000@cibs9.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/02 19:58, venom@sns.it wrote:
> On Sat, 12 Oct 2002, jw schultz wrote:
>
> So my 2 eurocents are for EVMS with "also" a LVM1 like command line.

EVMS has this already (same syntax exactly).

eg.

monty:~# evms_lvcreate -h
Enterprise Volume Management System
International Business Machines  09/30/02
LVM Emulation Utilities 1.2.0

evms_lvcreate -- initialize a logical volume for use by EVMS

evms_lvcreate [-A|--autobackup {y|n}] [-C|--contiguous {y|n}] [-d|--debug]
	[-h|--help] [-i|--stripes Stripes [-I|--stripesize StripeSize]]
	{-l|--extents LogicalExtentsNumber |
	 -L|--size LogicalVolumeSize[kKmMgGtT]} [-n|--name LogicalVolumeName]
	[-p|--permission {r|rw}] [-r|--readahead ReadAheadSectors]
	[-v|--verbose] [-Z|--zero {y|n}] [--version]
	VolumeGroupName [PhysicalVolumePath...]

evms_lvcreate -s|--snapshot [-c|--chunksize ChunkSize]
	{-l|--extents LogicalExtentsNumber |
	 -L|--size LogicalVolumeSize[kKmMgGtT]}
	-n|--name SnapshotLogicalVolumeName
	LogicalVolume[Path] [PhysicalVolumePath...]

monty:~# /sbin/lvcreate -h
Logical Volume Manager 1.0.4
Heinz Mauelshagen, Sistina Software  02/05/2002 (IOP 10)

lvcreate -- initialize a logical volume for use by LVM

lvcreate [-A|--autobackup {y|n}] [-C|--contiguous {y|n}] [-d|--debug]
[-h|--help] [-i|--stripes Stripes [-I|--stripesize StripeSize]]
	{-l|--extents LogicalExtentsNumber |
	 -L|--size LogicalVolumeSize[kKmMgGtT]} [-n|--name LogicalVolumeName]
	[-p|--permission {r|rw}] [-r|--readahead ReadAheadSectors]
	[-v|--verbose] [-Z|--zero {y|n}] [--version]
	VolumeGroupName [PhysicalVolumePath...]

lvcreate -s|--snapshot [-c|--chunksize ChunkSize]
	{-l|--extents LogicalExtentsNumber |
	 -L|--size LogicalVolumeSize[kKmMgGtT]}
	-n|--name SnapshotLogicalVolumeName
	LogicalVolume[Path] [PhysicalVolumePath...]

