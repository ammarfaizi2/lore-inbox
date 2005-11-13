Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVKMMqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVKMMqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 07:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKMMqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 07:46:20 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:54147 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932280AbVKMMqU (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 13 Nov 2005 07:46:20 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17271.13688.298525.23645@gargle.gargle.HOWL>
Date: Sun, 13 Nov 2005 15:45:44 +0300
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Severe VFS Performance Issues 2.6 with > 95000 directory entries
Newsgroups: gmane.linux.kernel
In-Reply-To: <4376B787.9000108@soleranetworks.com>
References: <4376B787.9000108@soleranetworks.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey writes:
 > 
 > The subject line speaks for itself.   This is using standard VFS readdir 
 > and lookup calls through the VFSwith ftp.  Very poor. 

Reiser4 works fine with 100M entries in a directory, so VFS is not a
bottleneck here.

[...]

 > 
 > Jeff

Nikita.
