Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSC0Utt>; Wed, 27 Mar 2002 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSC0Utk>; Wed, 27 Mar 2002 15:49:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:27014 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S290818AbSC0Ut1>;
	Wed, 27 Mar 2002 15:49:27 -0500
Date: Tue, 26 Mar 2002 19:08:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: [patch] Device model update (with power state transitions)
Message-ID: <20020326190842.C324@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203261458000.3237-100000@segfault.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 3. Adds the routines for power state transitions:
> 
> - device_suspend - forward iteration of list, calling suspend callback of 
>   each node
> - device_resume - backward iteration of list, calling resume callback of 
>   each node
> - device_shutdown - forward iteration of list, calling remove callback of 
>   each node
> 
> This should provide the mechanism for replacing the reboot notifiers and 
> doing properly ordered power management transtions. Comments welcome. 
> 
> Testing welcome also, though I wouldn't expect one to get very far, since 
> they're not actually used. ;) Which, brings up another question - what 

Well, I have patches for S3 that rely on them... I can post them to the
list if it helps testing ;-).

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

