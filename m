Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKMVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKMVeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKMVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:34:44 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:15311 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750710AbVKMVen (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 13 Nov 2005 16:34:43 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17271.45438.735874.747393@gargle.gargle.HOWL>
Date: Mon, 14 Nov 2005 00:34:54 +0300
To: jmerkey <jmerkey@soleranetworks.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Severe VFS Performance Issues 2.6 with > 95000 directory entries
In-Reply-To: <4377A999.7090305@soleranetworks.com>
References: <4376B787.9000108@soleranetworks.com>
	<17271.13688.298525.23645@gargle.gargle.HOWL>
	<4377A999.7090305@soleranetworks.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey writes:
 > Nikita Danilov wrote:
 > 
 > >Jeff V. Merkey writes:
 > > > 
 > > > The subject line speaks for itself.   This is using standard VFS readdir 
 > > > and lookup calls through the VFSwith ftp.  Very poor. 
 > >
 > >Reiser4 works fine with 100M entries in a directory, so VFS is not a
 > >bottleneck here.
 > >  
 > >
 > 
 > how about with ftp running on top? Try running FTP in directory with
 > 100M entries. See how long it takes to return the data to
 > the remote client for a dir listing.

Why are you thinking that it is VFS that is causing performance
degradation here?

 > 
 > Jeff
 > 
 > >[...]
 > >
 > > > 
 > > > Jeff
 > >

Nikita.

 > >
 > >  
 > >
