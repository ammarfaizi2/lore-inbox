Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290627AbSA3Vei>; Wed, 30 Jan 2002 16:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290626AbSA3Ve0>; Wed, 30 Jan 2002 16:34:26 -0500
Received: from imo-m08.mx.aol.com ([64.12.136.163]:25323 "EHLO
	imo-m08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S290627AbSA3Vdv>; Wed, 30 Jan 2002 16:33:51 -0500
Date: Wed, 30 Jan 2002 16:33:06 EST
From: Telford002@aol.com
Subject: [NFS] Incompatibility with Solaris?
To: <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Message-ID: <193.1d5ab9f.2989c093@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed Suse 7.3 on my workstation and then exported the file
system to a Solaris 2.6 x86 development station.

I executed a build/make script on the Solaris workstation in
a directory tree on the NFS exported file system.

The build/make script creates some symbolic links during
the build process.  I notice that the paths to the real
file are sometimes trash.  I suspect some sort of RPC
problem with symbolic links.  Build/make procedures
that create no symbolic links have no problems.

The Suse 7.3 distribution uses a 2.4.10 kernel.
I tried a 2.4.17 kernel.  I received a message
on the Solaris console that the RPC version in
2.4.17 was incompatible.

I have a work around, but it might be worthwhile 
to check out.

Note that not every symbolic link created on the
NFS file system during the build procedure is bad,
just a few of them.

Joachim Martillo

