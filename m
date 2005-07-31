Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263218AbVGaNzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263218AbVGaNzi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbVGaNzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:55:38 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:7400 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263218AbVGaNzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n0lL8tvPTifzrWnGJ2Hr0L05VKWLMj6D9bGaXaFUQaAueKX9Faj+O0EpcnaVxO79aAcJmEOus1V4Ei0QC/hcEkytZC9G4s3xhbqk78BnwjBbXEgEC0FfOep1DBEyLyBiujTkVOcW1yojc6kpkEsc0IXKAiWHhs7EyCB0jyz94z8=
Message-ID: <6f6293f10507310655243e7c4e@mail.gmail.com>
Date: Sun, 31 Jul 2005 15:55:33 +0200
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: 2.6.13-rc4-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42ECE2FE.2090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050731020552.72623ad4.akpm@osdl.org>
	 <6f6293f105073103045fd32d61@mail.gmail.com>
	 <42ECE2FE.2090204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Why was the KERNEL_VERSION(a,b,c) macro removed from
> >include/linux/version.h? The removal breaks external drivers like
> >NDISWRAPPER or nVidia propietary.
> >
> Hello Felipe,
> 
> I could not regonize a breakage of NVidia (Version 1.0-7667) propietary
> drivers.
> They work just perfect.

Indeed they do work perfectly, but I can't compile them (from the
nVidia package) without adding back the KERNEL_VERSION macro in file
include/linux/version.h.
