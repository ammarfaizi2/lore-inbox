Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132516AbRC1HKw>; Wed, 28 Mar 2001 02:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132522AbRC1HKl>; Wed, 28 Mar 2001 02:10:41 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:38417 "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP id <S132516AbRC1HK3>; Wed, 28 Mar 2001 02:10:29 -0500
Date: Tue, 27 Mar 2001 23:08:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14i5Y9-0004qx-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10103272306030.17821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001, Alan Cox wrote:

> They will mostly break. Installers tend to parse /proc/scsi and have fairly
> complex ioctl based relationships based on knowing ide v scsi.
> 
> /dev/disc/ is a little un-unix but its clean

Then make a '/proc/block/{ide|scsi|raid|wtf|ram|net}' which has a string
name for a real mknod thingy that includes the major|minor of the animal.

Is this simpler than the problem?


Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

