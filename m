Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFOLYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 07:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFOLYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 07:24:23 -0400
Received: from smtp.terra.es ([213.4.129.129]:38227 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S262151AbTFOLYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 07:24:23 -0400
Date: Sun, 15 Jun 2003 13:36:30 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, felipe_alfaro@linuxmail.org
Subject: Re: 2.5 and module loading
Message-Id: <20030615133630.787dd8a4.diegocg@teleline.es>
In-Reply-To: <1055664420.631.7.camel@teapot.felipe-alfaro.com>
References: <200306150653.h5F6r3007462@tessla.levonline.com>
	<20030615070648.GA8576@triplehelix.org>
	<1055664420.631.7.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2003 10:07:01 +0200
Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> For RedHat users, there's another pitfall in "/etc/rc.sysinit". During
> startup, the script sets up the binary used to dynamically load modules
> stored at "/proc/sys/kernel/modprobe". The initscript looks for
> "/proc/ksyms" (if my memory servers me well), but since it doesn't exist
> in 2.5 kernels, the binary used is "/sbin/true" instead.
> 
> This, eventually, will keep modules from working. RedHat users will have
> to patch the "/etc/rc.sysinit" script to set "/proc/sys/kernel/modprobe"
> to "/sbin/modprobe", even when "/proc/ksyms" doesn't exist.
> 
> I can't attach a patch. All my RH9 boxes are manually patched and can't
> get access to the original "/etc/rc.sysinit" script :-(

Dave, i think it'd be good to have this in your post-halloween document?

Regards,
Your spanish translator :)
