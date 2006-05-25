Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWEYEK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWEYEK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWEYEK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:10:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57034 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964961AbWEYEKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:10:25 -0400
Date: Thu, 25 May 2006 09:36:04 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060525040604.GB25185@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060524110001.GU1331387@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060524110001.GU1331387@melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Shrink the dentry LRU on æ given superblock.
			      ^^^
This character (ae) looks strange.

The other changes look fine. Do you have any performance numbers, any
results from stress tests (for version 2 of the patch)?

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
