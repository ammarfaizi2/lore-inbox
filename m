Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUHWPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUHWPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUHWPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:30:25 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:14583 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S264937AbUHWPJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:09:24 -0400
Message-ID: <412A087A.90300@ttnet.net.tr>
Date: Mon, 23 Aug 2004 18:08:42 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10]
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 06:17:41PM +0300, O.Sezer wrote:

 >> --- 28p1/include/linux/fs.h~	2004-08-16 20:23:00.000000000 +0300
 >> +++ 28p1/include/linux/fs.h	2004-08-17 13:02:49.000000000 +0300

 >> And what about the actual function declaration in mm/ ?

Looking into this (slowly, not a good day :/ ).  It only served
to fix compilation of fs/xfs/linux-2.4/xfs_lrw.c (its only direct
user, iirc). Will see if can find anything better.
