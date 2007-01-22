Return-Path: <linux-kernel-owner+w=401wt.eu-S1751848AbXAVBI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXAVBI7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 20:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXAVBI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 20:08:59 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:45017 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXAVBI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 20:08:58 -0500
Message-ID: <45B41F79.20409@wolfmountaingroup.com>
Date: Sun, 21 Jan 2007 19:20:41 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: i_ino 4 billion file limitation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am now pushing up against the i_ino (unsigned long) file limitation 
when I use virtual inode numbers in DSFS.  This field needs to be increased
to 64 bit to allow more than 4 billion unique inode numbers.   I am 
running out of inode address space with the current architecture.

Jeff
