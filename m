Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287852AbSAIVm6>; Wed, 9 Jan 2002 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289028AbSAIVmt>; Wed, 9 Jan 2002 16:42:49 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:52752 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287852AbSAIVmn>;
	Wed, 9 Jan 2002 16:42:43 -0500
Date: Wed, 9 Jan 2002 13:40:22 -0800
From: Greg KH <greg@kroah.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109214022.GE21963@kroah.com>
In-Reply-To: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 17:23:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:34:34PM +0000, Anton Altaparmakov wrote:
> Partition discovery is currently done within the kernel itself. The code 
> will effectively 'just' move out into user space. As such it is not present 
> in /sbin now but it will be in initramfs. The same is true for various 
> other code I can imagine moving out of kernel mode into initramfs...

For this code, I can see it staying in the kernel source tree, and being
built as part of the kernel build process, right?

greg k-h
