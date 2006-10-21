Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161480AbWJUMw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbWJUMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161479AbWJUMw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:52:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161477AbWJUMwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:52:54 -0400
Message-ID: <453A17E0.7080301@redhat.com>
Date: Sat, 21 Oct 2006 07:51:44 -0500
From: Robert Peterson <rpeterso@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Josef \"Jeff\" Sipek" <jsipek@cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@infradead.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: [PATCH 05 of 23] ext3: change uses of f_{dentry, vfsmnt} to use
 f_path
References: <b75a8d7cedacd1de45bc.1161411450@thor.fsl.cs.sunysb.edu>
In-Reply-To: <b75a8d7cedacd1de45bc.1161411450@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Jeff Sipek wrote:
> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
>
> This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
> in the ext3 filesystem.
>   
Hey Jeff,

Don't forget about GFS2:  fs/gfs2/ops_file.c.

Regards,

Bob Peterson
Red Hat Cluster Suite

