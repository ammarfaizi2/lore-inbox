Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTD2NcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTD2NcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:32:01 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:36844 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S262000AbTD2Nb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:31:58 -0400
Date: Tue, 29 Apr 2003 16:35:13 +0300
From: Nir Livni <nirl@cyber-ark.com>
Subject: RE: FileSystem Filter Driver
To: linux-kernel@vger.kernel.org
Message-id: <E1298E981AEAD311A98D0000E89F45134B55D5@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Muli,
Your answer has been a great help

Nir

-----Original Message-----
From: Muli Ben-Yehuda [mailto:mulix@mulix.org] 
Sent: Wednesday, April 23, 2003 3:22 PM
To: Nir Livni
Cc: linux-kernel@vger.kernel.org
Subject: Re: FileSystem Filter Driver

On Wed, Apr 23, 2003 at 02:20:38PM +0200, Nir Livni wrote:

> My goal is to write a driver that runs above the filesystem driver, 
> and filters calls to this driver. Actually, it should pass all calls 
> to the filesystem driver, except very few that it should fail for 
> "Access Denied". Are there any simple examples for that matter ?

A. Sounds like it could be implemented using the LSM (linux security
modules) framework, assuming the appropriate hooks are in place. 

B. The May 2003 Linux Journal issue has an article on "Writing Stackable
Filesystems" by Erez Zadok, which might fit your needs better.

Hope this helps, 
Muli. 
-- 
Muli Ben-Yehuda
http://www.mulix.org



