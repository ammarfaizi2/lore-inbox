Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSDXMEa>; Wed, 24 Apr 2002 08:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSDXME3>; Wed, 24 Apr 2002 08:04:29 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:57142 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311884AbSDXME2>;
	Wed, 24 Apr 2002 08:04:28 -0400
Date: Wed, 24 Apr 2002 13:04:11 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.name>
X-X-Sender: <tigran@einstein.homenet>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST2][BUG] RAMFS broken in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.44.0204241357230.8961-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0204241301240.3767-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
> Too much mess.
>
> Of course, the /proc/devices was from my computer, compiled without proper
> ramfs support. I don't have /proc/devices from the other one, as I can't
> boot it, lacking RAMFS support.

actually, even more mess than you think, namely what you keep calling
RAMFS (and ramfs) has nothing to do with ramfs. The ramfs is not needed to
use ramdisk block devices. See CONFIG_RAMFS for more info.

Btw, there is also tmpfs but that has nothing to do with it either :)

Regards,
Tigran

