Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUC2Liw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUC2Liw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:38:52 -0500
Received: from localhost.nl ([62.250.6.43]:10003 "HELO maiden.localhost.nl")
	by vger.kernel.org with SMTP id S262826AbUC2Liv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:38:51 -0500
Date: Mon, 29 Mar 2004 13:38:50 +0200
From: Marco Baan <marco@freebsd.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: failure to mount root fs
Message-ID: <20040329113850.GA21283@maiden.localhost.nl>
References: <26889266.1080559781017.JavaMail.www@wwinf3002>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26889266.1080559781017.JavaMail.www@wwinf3002>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > VFS: Unable to mount root fs on unknown-block(0,0)
> > ...
> > kernel /boot/bzImage-2.6.4 ro root=LABEL=/
> 
> The "LABEL=/" is the attempt to mount root filesystem by label, so you can 
> move it to another disk. I find these "clever" things not mature yet and always replace it by an explicit device name (and don't move/replace root disk):
> 
> kernel /boot/bzImage-2.6.4 ro root=/dev/hda2
> 
> (this assumes that your root fs is on /dev/hda2, change it appropriately to match your situation)
> 

Okay, changed it. Didnt make a difference however.

-- 
Marco Baan

"MacDonald has the gift on compressing the largest amount of words into
the smallest amount of thoughts."
		-- Winston Churchill
