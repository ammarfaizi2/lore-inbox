Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291191AbSBGSe6>; Thu, 7 Feb 2002 13:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291218AbSBGSdV>; Thu, 7 Feb 2002 13:33:21 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:5180
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S291194AbSBGScX>; Thu, 7 Feb 2002 13:32:23 -0500
Message-ID: <3C62C831.9010302@switchmanagement.com>
Date: Thu, 07 Feb 2002 10:32:17 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCI Hotplug and Linux 2.5.4-pre2
In-Reply-To: <3C62C4AB.3040109@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:

> I can't find the definition of pcihpfs_fs_type used in 
> pci_hotplug_core.c in register_filesystem(), unregister_filesystem(),
> and kern_mount().  This is causing a compilation error.
>
> PS - I don't use this in my kernel, so I can disable it from my
> config without penalty.  But seeing as I don't see any posts
> about this on LKML, should I try to build kernels with everything
> enabled in the future (just to get these small errors stomped out
> quickly)? 

I vote yes; I always turn on as many modularizable chunks as possible, 
to increase "compile coverage".  And we all know if it compiles, it 
works, right?


