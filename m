Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTAVHP7>; Wed, 22 Jan 2003 02:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTAVHP7>; Wed, 22 Jan 2003 02:15:59 -0500
Received: from terminus.zytor.com ([63.209.29.3]:51918 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267366AbTAVHP6>; Wed, 22 Jan 2003 02:15:58 -0500
Message-ID: <3E2E4736.8010804@zytor.com>
Date: Tue, 21 Jan 2003 23:24:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
References: <200301111603.RAA06278@harpo.it.uu.se>
In-Reply-To: <200301111603.RAA06278@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> While I have no particular affection for the in-kernel boot loader,
> I do care about being able to test new kernels with 'make bzdisk'
> as a regular user, using raw (no file system) floppies.
> 
> Last time I checked, LILO required both a file system and root privs
> (for FIBMAP). Would syslinux work better?
> 

SYSLINUX will work if (a) you have write permission to the device and 
(b) the device is included in /etc/fstab with "user" permissions.

	-hpa



