Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWECJmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWECJmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWECJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:42:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:7069 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965133AbWECJmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:42:05 -0400
Date: Wed, 3 May 2006 12:42:01 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: [PATCH] s390: Hypervisor File System
In-Reply-To: <OF0EA76F71.9AA7937D-ON42257163.003067FA-42257163.00347656@de.ibm.com>
Message-ID: <Pine.LNX.4.58.0605031239001.10675@sbz-30.cs.Helsinki.FI>
References: <OF0EA76F71.9AA7937D-ON42257163.003067FA-42257163.00347656@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Michael Holzheu wrote:
> All the complicated mechanisms with filesystem trees
> to obtain consistent data and transaction functionality
> could be avoided, if we would use single files, which
> contain all the data. When opening the file, the snapshot
> is created and attached to the struct file.

If we're going to add new infrastructure, I'd vote for adding snapshotting 
capability to filesystems. We need it for stuff like LogFS anyway.

				Pekka
