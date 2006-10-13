Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWJMPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWJMPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWJMPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:09:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2706 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751139AbWJMPJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:09:24 -0400
Date: Fri, 13 Oct 2006 10:09:21 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, phillip@hellewell.homeip.net
Subject: Re: [PATCH] ecryptfs: superblock cleanups
Message-ID: <20061013150921.GB3513@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <Pine.LNX.4.64.0610131040020.17802@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610131040020.17802@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:41:21AM +0300, Pekka J Enberg wrote:
>   - Kill useless ecryptfs_set_superblock_private wrapper
>   - Rename ecryptfs_superblock_to_private to ecryptfs_sb for readability

Okay, but if we are going to do this for the superblock info struct,
why not do it for all objects (file, dentry, and inode) in order to
maintain naming consistency? That would be a pretty large, yet
functionally trivial, patch. Is there a general interest in doing
this?
