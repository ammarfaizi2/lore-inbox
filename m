Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVH1GzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVH1GzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 02:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVH1GzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 02:55:04 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:54532 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1750764AbVH1GzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 02:55:03 -0400
Message-ID: <43115FC2.30309@roarinelk.homelinux.net>
Date: Sun, 28 Aug 2005 08:54:58 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Marineau <marineam@engr.orst.edu>
CC: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Radeon acpi vgapost
References: <43111298.80507@engr.orst.edu>
In-Reply-To: <43111298.80507@engr.orst.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Marineau wrote:
> Thses patches resume ATI radeon cards from acpi S3 suspend when using
> radeonfb by reposting the video bios. This is needed to be able to use
> S3 when the framebuffer is enabled.

These patches break resume from S3 for me. On a vanilla kernel,
radeonfb comes back fine, with your patches applied, the backlight
gets turned on (by BIOS I think) and shortly afterwards its turned off
for good. (Radeon M11 on Sony Vaio)

-- 
  Manuel Lauss

