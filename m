Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVAEUGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVAEUGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVAEUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:06:45 -0500
Received: from sommereik.ii.uib.no ([129.177.16.236]:30851 "EHLO
	sommereik.ii.uib.no") by vger.kernel.org with ESMTP id S262579AbVAEUGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:06:40 -0500
Date: Wed, 5 Jan 2005 20:57:36 +0100
From: Jan-Frode Myklebust <Jan-Frode.Myklebust@bccs.uib.no>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Cc: Eirik Thorsnes <eithor@ii.uib.no>
Subject: panic - Attempting to free lock with active block list
Message-ID: <20050105195736.GA26989@ii.uib.no>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Eirik Thorsnes <eithor@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a couple of mail-servers running first 2.6.9-1.681_FC3smp
and was later upgraded to the Fedora test kernel 2.6.10-1.727_FC3smp
which I think is pretty plain 2.6.10 + ac2. But they both keep
crashing with the message:

       Kernel panic - not syncing: Attempting to free lock with active block list

Any ideas how to attack this?

We're running Centos 3.3, ext3 for root-disks, ext2 on /boot,
XFS for mail-spools, lots of nfs-mounted directories..


  -jf
