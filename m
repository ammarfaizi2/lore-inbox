Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUAZL6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAZL6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:58:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:36225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbUAZL6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:58:39 -0500
Date: Mon, 26 Jan 2004 03:57:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bart Samwel <bart@samwel.tk>
Cc: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040126035758.70e620e9.akpm@osdl.org>
In-Reply-To: <4014FF00.1020106@samwel.tk>
References: <20040124181026.GA22100@codeblau.de>
	<20040124153551.24e74f63.akpm@osdl.org>
	<40144A36.5090709@samwel.tk>
	<20040125150914.1583d487.akpm@osdl.org>
	<4014516D.5070409@samwel.tk>
	<20040125153803.4d7e1015.akpm@osdl.org>
	<4014FF00.1020106@samwel.tk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> wrote:
>
> 2. Swapfiles apparently don't like to be touched. I did an 
>  ioctl(FIGETBSZ) on a swapfile, and it would simply block until I did a 
>  swapoff on the file. I didn't even get to the FIBMAP part. :( Is this 
>  correct behaviour?

yup.

> And is there any way to detect this so that I can work around it?

swapoff -a beforehand, I guess.
