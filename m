Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUAOTGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUAOTGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:06:11 -0500
Received: from sandershosting.com ([69.26.136.138]:46274 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S262033AbUAOTGG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:06:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401151401.1764@sandersweb.net>
To: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Re: NTFS disk usage on Linux 2.6
Date: Thu, 15 Jan 2004 14:05:41 -0500
X-Mailer: KMail [version 1.3.2]
References: <20040115010210.GA570@s.chello.no>
In-Reply-To: <20040115010210.GA570@s.chello.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 January 2004 08:02 pm, Haakon Riiser wrote:
> Has anyone else noticed that the reported disk space usage on
> NTFS is completely unreliable on Linux 2.6?  Just issued the

I'm having the same symptom.  The following is on a 4G partition.  The 
WINNT directory is reported as 66G in size.  Kernel 2.6.1.

david@debian:/mnt/hda5$ du * -sh
124M    file
56M     GNUwin32
6.3M    Inetpub
1.3M    lynx
0       Multimedia Files
267M    pagefile.sys
134M    perl
922M    Program Files
0       RECYCLER
42M     TEMP
2.7M    util
13M     vim
2.5k    _viminfo
66G     WINNT


-- 
David Sanders
linux@sandersweb.net
