Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVBOMUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVBOMUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVBOMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:20:36 -0500
Received: from alog0129.analogic.com ([208.224.220.144]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261704AbVBOMTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:19:43 -0500
Date: Tue, 15 Feb 2005 07:19:01 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: krishna <krishna.c@globaledgesoft.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the purpose of GPIO pins.
In-Reply-To: <4211E434.7060405@globaledgesoft.com>
Message-ID: <Pine.LNX.4.61.0502150713390.9458@chaos.analogic.com>
References: <4211E434.7060405@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, krishna wrote:

> Hi all,
>
>   Can any one tell me the purpose GPIO pin serves.
>   How are GPIO pins better than dedicated pins, considering hardware design 
> view and for programming view.
>

Do you mean General Purpose I/O bits on a chip?
             ^       ^       ^ ^
If so, it is intended to live in the lower 16 megabytes of
an ix86 machine (higher addresses are not decoded), and at one
time, went to the ISA bus, but is now usually a simple
asynchronous bus off from some bridge.

>From a hardware perspective, it's slow. From a programming
perspective, you don't care where it is.

> Regards,
> Krishna Chaitanya

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
