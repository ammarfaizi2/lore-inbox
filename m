Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVJ2PhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVJ2PhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJ2PhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:37:04 -0400
Received: from imo-d23.mx.aol.com ([205.188.139.137]:48610 "EHLO
	imo-d23.mx.aol.com") by vger.kernel.org with ESMTP id S1751200AbVJ2Pg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:36:58 -0400
From: AndyLiebman@aol.com
Message-ID: <74.5fcdf18f.3094f111@aol.com>
Date: Sat, 29 Oct 2005 11:36:49 EDT
Subject: Re: What happened to XFS Quota Support?
To: nathans@sgi.com
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In a message dated 10/28/2005 6:47:02 P.M. Eastern Standard Time,  
nathans@sgi.com >writes:
>This patch by Dimitri Puzin submitted through  kernel Bugzilla #5514 
>fixes the following issue:
>
>Cannot  build XFS filesystem support as module with quota support. It 
>works only  when the XFS filesystem support is compiled into the kernel. 
>Menuconfig  prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.
>
>Fix: Changing the fs/xfs/Kconfig file from tristate to bool lets you  
>configure the quota support to be compiled into the XFS module. The  
>Makefile-linux-2.6 checks only for CONFIG_XFS_QUOTA=y.
 
Just wanted to let you know this works fine. 
 
Andy Liebman
 
 
 
