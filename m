Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVKLEio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVKLEio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVKLEin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:38:43 -0500
Received: from bay103-f13.bay103.hotmail.com ([65.54.174.23]:27387 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751300AbVKLEin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:38:43 -0500
Message-ID: <BAY103-F135A769ABB42E29158E0DBAA580@phx.gbl>
X-Originating-IP: [24.16.111.185]
X-Originating-Email: [mhearse@hotmail.com]
From: "Matt Hersant" <mhearse@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: inode kernel option for HA clustering/rsync
Date: Sat, 12 Nov 2005 04:38:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Nov 2005 04:38:42.0669 (UTC) FILETIME=[F5BE89D0:01C5E742]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a clustering project which utilizes rsync for system 
mirroring.  A main priority is to reduce rsync runtime and IO load.  I have 
heard of a kernel 'inode' option which can be used to cache a list of 
modified files.  The list of files is then passed to rsync on the next run.  
Has anyone heard of this kernel option.  Thanks in advance.


