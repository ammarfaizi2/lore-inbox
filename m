Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTBCPZm>; Mon, 3 Feb 2003 10:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBCPZm>; Mon, 3 Feb 2003 10:25:42 -0500
Received: from pointblue.com.pl ([62.121.131.135]:45831 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266717AbTBCPZl>;
	Mon, 3 Feb 2003 10:25:41 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
References: <1044284924.2402.12.camel@gregs>
	 <1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1044286828.2433.24.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 15:40:29 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 16:18, Alan Cox wrote:

> Firstly vmalloc isnt permitted in interrupt context (use kmalloc with GFP_KERNEL),
> although for such small chunks you might want to vmalloc a bigger buffer once
> at startup.
i've allso tried kmalloc with the same result.
Also, in this example it is timer - module isn't cleanly wroted becouse
it supose to be only an example.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

