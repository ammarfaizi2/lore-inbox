Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVCVJ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVCVJ4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVCVJ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:56:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:29632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVCVJ4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:56:41 -0500
Date: Tue, 22 Mar 2005 01:55:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-Id: <20050322015538.5db28ed5.akpm@osdl.org>
In-Reply-To: <423FE7C5.8080402@telefonica.net>
References: <422618F0.3020508@telefonica.net>
	<20050321141049.5d804609.akpm@osdl.org>
	<423FE7C5.8080402@telefonica.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> wrote:
>
> >You appear to have about five bugs here.  Do any of them remain in
>  >2.6.12-rc1?
>  >  
>  >
>  Well, one thing outstands: the synaptic touchpad is now really 
>  comfortable to use. Almost everything works, including simple and double 
>  clicks, and scrolling. Dragging is still broken. I must note I'm now 
>  using a synaptic Xinput driver, as suggested.
> 
>  The system seems much more stable in regard to suspension/resuming. The 
>  USB subsystem has kept working the first time I suspended and everything 
>  came back perfect. The second one in a row, the USB subsystem was 
>  halted, but doing a "modprobe -r uhci_hcd; modprobe uhci_hcd" made my 
>  USB periferals (keyboard and mouse) work again.
> 
>  As for the battery charging pattern, I can't say anything definitive, 
>  but it looks good ATM.
> 
>  No more "Ramdom Nasty Things(tm)", the clock works ok and there are no 
>  issues with proccess spawning.
> 
>  9/10?

Let's go for 10/10.  I assume that dragging _used_ to work, yes?

Also, I'd consider it a regression that you had to go and find new X
drivers due to a kernel change.  We shouldn't do that.
