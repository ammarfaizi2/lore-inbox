Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSBFECu>; Tue, 5 Feb 2002 23:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSBFECk>; Tue, 5 Feb 2002 23:02:40 -0500
Received: from f42.law8.hotmail.com ([216.33.241.42]:7178 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S287631AbSBFECf>;
	Tue, 5 Feb 2002 23:02:35 -0500
X-Originating-IP: [4.35.96.158]
From: "Jim Lu" <jiml789@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Ext2 Inode question
Date: Tue, 05 Feb 2002 20:02:29 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F42jlQ0txV6JpoA7p590000e5a6@hotmail.com>
X-OriginalArrivalTime: 06 Feb 2002 04:02:30.0270 (UTC) FILETIME=[18E681E0:01C1AEC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me on replies)

I have a question regarding the inode number on the EXT2 filesystem. If I 
get a Inode number, is there a way I can calculate the block address (with 
respect to the filesystem) on this inode base on the inode number?
I know for UFS, you can calculate the address of the inode base on the inode 
number.

Also, I remember reading somewhere that not all the EXT2 block groups have 
superblock information. So would the beginning of those block group look 
like this " group descriptor | block bitmap | inode bitmap | inode table | 
data " ? And, could someone please tell me which block groups have 
superblock info.

Thank you for your time.

Jim

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

