Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRC3Jrl>; Fri, 30 Mar 2001 04:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRC3Jqe>; Fri, 30 Mar 2001 04:46:34 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:35146 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131304AbRC3JqM>; Fri, 30 Mar 2001 04:46:12 -0500
Date: Fri, 30 Mar 2001 03:45:28 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Amit D Chaudhary <amit@muppetlabs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in the ramfs file system
In-Reply-To: <3AC3F91B.4020804@muppetlabs.com>
Message-ID: <Pine.LNX.3.96.1010330034506.8826F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Amit D Chaudhary wrote:
>  >(none):/mnt/ramfs/root# df -h /mnt/ramfs/
>  >Filesystem            Size  Used Avail Use% Mounted on
>  >ramfs                    0     0     0   -  /mnt/ramfs
> I am not sure, how related this is, but we have / on ramfs and using rpm 
> to install(-iUvh) fails with the mesages, need 12K on /

This is normal -- ramfs doesn't do filesystem accounting needed for 'df'.

