Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSK0NjZ>; Wed, 27 Nov 2002 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSK0NjZ>; Wed, 27 Nov 2002 08:39:25 -0500
Received: from services.cam.org ([198.73.180.252]:48062 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262620AbSK0NjY>;
	Wed, 27 Nov 2002 08:39:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: Reiserfs fs corruption with 2.5.49
Date: Wed, 27 Nov 2002 08:46:30 -0500
User-Agent: KMail/1.4.3
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
References: <200211270810.06553.tomlins@cam.org> <15844.50995.61298.126680@laputa.namesys.com>
In-Reply-To: <15844.50995.61298.126680@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211270846.30257.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 27, 2002 08:22 am, Nikita Danilov wrote:
> Ed Tomlinson writes:
>  > Hi,
>  >
>  > I am seeing reiserfs (3.6 r5 hash) fs corruption in 2.5.49
>  >
>  > oscar% ls alsa*
>  > zsh: no matches found: alsa*
>  > oscar% ls mod*
>  > alsa-driver-0.9+0beta4-4
>  > oscar% rm "alsa-driver-0.9+0beta4-4"
>  > rm: cannot remove `alsa-driver-0.9+0beta4-4': No such file or directory
>
> This can be explained if you have file alsa-driver-0.9+0beta4-4 within
> directory named modSOMETHING, right? Can you try
>
> $ ls -d ls mod*

YES.  Thanks - stupid me.  I this case I am glad to be wrong though.

Ed Tomlinson
