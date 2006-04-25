Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWDYOpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWDYOpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWDYOpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:45:30 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42447 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932238AbWDYOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:45:30 -0400
Date: Tue, 25 Apr 2006 16:45:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Michael Holzheu <holzheu@de.ibm.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Message-ID: <20060425144524.GA12940@wohnheim.fh-wedel.de>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com> <1145975582.11508.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1145975582.11508.13.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 April 2006 17:33:01 +0300, Pekka Enberg wrote:
> 
> To state what I said earlier: the use of a global hypfs_sblk is
> problematic because now we can only have the filesystem mounted once. So
> I would really like to see some other way of updating. How do you feel
> about the s_ops->fs_remount thing?

It sounds as if part of hypfs is a global resource.  Maybe the code
could be split between a global get-and-store-data part and a
per-filesystem representation part?

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
