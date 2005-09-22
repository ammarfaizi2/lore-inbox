Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVIVLyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVIVLyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 07:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVIVLyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 07:54:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:26293 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030267AbVIVLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 07:54:45 -0400
Date: Thu, 22 Sep 2005 13:54:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
Message-ID: <20050922115447.GA4548@wohnheim.fh-wedel.de>
References: <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz> <20050922113430.GA2732@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050922113430.GA2732@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 September 2005 13:34:30 +0200, Jörn Engel wrote:
> 
> Noone bothered defining it, but most everyone is happy about it being
> as it is.  Non-journalling filesystems would have severe corruption on
> unclean umounts.  lost+found would fill up much faster than people are
> used to, if 4-6 was common for hard disks.

Worse, actually.  Corruption will also happen for file data, which may
pass fsck just fine.  Your data is gone and noone told you about it.
;)

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
