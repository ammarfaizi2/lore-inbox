Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbRCGU7H>; Wed, 7 Mar 2001 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbRCGU64>; Wed, 7 Mar 2001 15:58:56 -0500
Received: from niwot.scd.ucar.edu ([128.117.8.223]:17802 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S131181AbRCGU6m>; Wed, 7 Mar 2001 15:58:42 -0500
Date: Wed, 7 Mar 2001 13:58:11 -0700
From: Craig Ruff <cruff@ucar.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <20010307135811.A20146@bells.scd.ucar.edu>
In-Reply-To: <Pine.SUN.4.21.0103070713500.22298-100000@panix5.panix.com> <Pine.LNX.4.10.10103071225510.19253-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10103071225510.19253-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Mar 07, 2001 at 12:32:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 12:32:08PM -0800, Andre Hedrick wrote:
> The SCSI low-level format glue performed by the HOST gets destroyed
> If you write to LBA Zero.

This is simply not true.  I write to SCSI disk's block 0 all of the time
and never loose data.  Obviously, you can lose the partition information
if that is where it is kept.  I've also never had trouble with SCSI
disks correctly writing multiple sectors starting at block zero.  This
includes older Quantum drives.
