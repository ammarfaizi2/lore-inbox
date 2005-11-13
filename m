Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKMV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKMV13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKMV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:27:29 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:6528 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1750718AbVKMV12
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 13 Nov 2005 16:27:28 -0500
Message-ID: <4377A999.7090305@soleranetworks.com>
Date: Sun, 13 Nov 2005 14:01:13 -0700
From: jmerkey <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Severe VFS Performance Issues 2.6 with > 95000 directory entries
References: <4376B787.9000108@soleranetworks.com> <17271.13688.298525.23645@gargle.gargle.HOWL>
In-Reply-To: <17271.13688.298525.23645@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Jeff V. Merkey writes:
> > 
> > The subject line speaks for itself.   This is using standard VFS readdir 
> > and lookup calls through the VFSwith ftp.  Very poor. 
>
>Reiser4 works fine with 100M entries in a directory, so VFS is not a
>bottleneck here.
>  
>

how about with ftp running on top? Try running FTP in directory with
100M entries. See how long it takes to return the data to
the remote client for a dir listing.

Jeff

>[...]
>
> > 
> > Jeff
>
>Nikita.
>
>  
>


