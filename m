Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWEZVNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWEZVNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEZVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:13:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750797AbWEZVNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:13:20 -0400
Date: Fri, 26 May 2006 14:16:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
Message-Id: <20060526141603.054f0459.akpm@osdl.org>
In-Reply-To: <20060526162902.227348000@gmail.com>
References: <20060526161129.557416000@gmail.com>
	<20060526162902.227348000@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> Move the input.c to input-core.c and modify Makefile so that the input module
> can be built from multiple source files. This is preparing for the input-ff.c.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> 
> ---
>  drivers/input/Makefile     |    2 
>  drivers/input/input-core.c | 1099 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/input/input.c      | 1099 ---------------------------------------------

urgh.  There are other changes pending againt input.c and this renaming
makes everything a huge pain.

What does "can be built from multiple source files" mean?

It would be much nicer all round if we could avoid renaming this file.
