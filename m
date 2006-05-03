Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWECMLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWECMLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWECMLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:11:30 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:23643 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965167AbWECML3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:11:29 -0400
In-Reply-To: <Pine.LNX.4.58.0605031239001.10675@sbz-30.cs.Helsinki.FI>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       Kyle Moffett <mrmacman_g4@mac.com>, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF11F4EFE7.A54CB101-ON42257163.0042DA19-42257163.0042FB13@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 14:11:36 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 14:12:39
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pekka J Enberg <penberg@cs.Helsinki.FI> wrote on 05/03/2006 11:42:01 AM:
> On Wed, 3 May 2006, Michael Holzheu wrote:
> > All the complicated mechanisms with filesystem trees
> > to obtain consistent data and transaction functionality
> > could be avoided, if we would use single files, which
> > contain all the data. When opening the file, the snapshot
> > is created and attached to the struct file.
>
> If we're going to add new infrastructure, I'd vote for adding
snapshotting
> capability to filesystems. We need it for stuff like LogFS anyway.
>

Maybe we need that, too. But I think the advantage of the
one file solution moves the complexity from the kernel
to userspace.

Michael

