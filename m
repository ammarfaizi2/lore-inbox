Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbULDCKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbULDCKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 21:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbULDCKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 21:10:54 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:64979 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262520AbULDCKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 21:10:50 -0500
Message-ID: <41B11C92.30007@zytor.com>
Date: Fri, 03 Dec 2004 18:10:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: klibc@zytor.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [klibc] INITRAMFS: allow no trailer
References: <200412040147.iB41lIlK031974@sullivan.realtime.net>
In-Reply-To: <200412040147.iB41lIlK031974@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> 
> hpa points out that you should be careful with the headers, use unique
> inode numbers and/or add a cpio header with just TRAILER!!! to reset
> the inode hash table to avoid unwanted hard links.  I just put this
> sequence as the last files loaded.
> 

You still need unique inode numbers, though; just 1, 2, 3, ... is 
sufficient.

	-hpa
