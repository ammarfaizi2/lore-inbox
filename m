Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTLUJaL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 04:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLUJaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 04:30:10 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:20140 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262356AbTLUJaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 04:30:07 -0500
Subject: Re: lot of VM problem with 2.4.23
From: Peter Zaitsev <peter@mysql.com>
To: Octave <oles@ovh.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031221001422.GD25043@ovh.net>
References: <20031221001422.GD25043@ovh.net>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1071999003.2156.89.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 12:30:04 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-21 at 03:14, Octave wrote:
> Hi,
> Since we use 2.4.23 we have lot of crash. I have no kernel panic.
> All I can report is this kind of syslog's message:
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process rateup
> 
> Mysql doesn't like 2.4.23 either.
> SQL Error : 1 Can't create/write to file '/tmp/#sql2ec_1acd2_2.MYI' (Errcode: 30)

Octave,

This looks like for some reason  your /tmp file-system is read only or
for any other reason kernel returns this error code. 

Do not you have any more error messages dmesg or logs ? 

-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

