Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVBOPOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVBOPOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVBOPM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:12:29 -0500
Received: from smtpout17.mailhost.ntl.com ([212.250.162.17]:51521 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261746AbVBOPLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:11:23 -0500
Subject: Re: What is the Purpose of GPIO Controller.
From: Ian Campbell <ijc@hellion.org.uk>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <421206B5.1080204@globaledgesoft.com>
References: <421206B5.1080204@globaledgesoft.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 15:11:18 +0000
Message-Id: <1108480278.3324.19.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 19:57 +0530, krishna wrote:
> Form your mail I understand GPIO controller serves some Hardware 
> designers purpose.
> But what _purpose_ is it serving a _programmer_.

All a gpio controller does is allows the programmer to configure a line
as an input or an output, and then either read it or make it high or
low.

This allows the programmer to control the hardware. Exactly how and what
you control it is 100% a function of what the hardware designer has
done.

Unless you have access to documentation or the hardware engineers brain
you'll just have to work out what each line does by trial and error.

Ian.



-- 
Ian Campbell
Current Noise: Opeth - To Rid the Disease

Variables don't; constants aren't.

