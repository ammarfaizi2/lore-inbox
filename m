Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTDPQkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTDPQkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:40:19 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:13289 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP id S264492AbTDPQkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:40:04 -0400
Date: Thu, 17 Apr 2003 01:51:55 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: "Brien" <admin@brien.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Message-Id: <20030417015155.4532f074.bharada@coral.ocn.ne.jp>
In-Reply-To: <003e01c30428$bb6de410$6901a8c0@athialsinp4oc1>
References: <003e01c30428$bb6de410$6901a8c0@athialsinp4oc1>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003 10:59:07 -0400
"Brien" <admin@brien.com> wrote:

> (I posted this on some forums and they recommended that I try here)
> 
> Hi,
> 
> I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400 (CL
> 2.5) RAM modules installed. Whenever I try to install any Linux
> distribution, I always get a black screen after the kernel loads, when I
> have dual channel enabled; If I take out 1 of the RAM modules (either one),
> everything works as it should -- it's not a bad module (works perfectly
> under Windows by the way).

A couple of things to try:
 - Put in both sticks, try booting from a distribution and pass the
   bootloader "mem=960M" as a parameter at the prompt.
 - Just to make sure it's not a memory problem, grab memtest86
   (http://www.memtest86.com/) and try running it for a few hours.
   Unlikely, but you never know.
