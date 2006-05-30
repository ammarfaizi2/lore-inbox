Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWE3TzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWE3TzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWE3TzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:55:21 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:17803 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932372AbWE3TzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:55:20 -0400
Date: Tue, 30 May 2006 10:44:48 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Pavel Machek <pavel@ucw.cz>
cc: Jeff Garzik <jeff@garzik.org>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <20060529214540.GB7537@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0605301043010.4786@qynat.qvtvafvgr.pbz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> 
 <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
  <20060529102339.GA746@elf.ucw.cz>  <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
  <20060529124840.GD746@elf.ucw.cz> <447B666F.5080109@garzik.org>
 <20060529214540.GB7537@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006, Pavel Machek wrote:

> Well, I agree that vesafb and vgacon need to exist and are useful for
> installation/servers/etc. I was arguing that some combinations are
> bad.
>
> Like vgacon + X + 3D acceleration.

why is this bad?

this lets the user of the box use as much as is needed, from plain text 
mode on up to accelerated modes. perfect for the user who sometimes needs 
a nimple, stripped down system and sometimes needs graphics (and if they 
need graphics it seems silly to deny them access to the accelerated 
features)

David Lang
