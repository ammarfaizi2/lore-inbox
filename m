Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWBTKfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWBTKfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWBTKfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:35:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964851AbWBTKfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:35:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <489ecd0c0602192340h710b5807r4bc3e66b25c59bd9@mail.gmail.com> 
References: <489ecd0c0602192340h710b5807r4bc3e66b25c59bd9@mail.gmail.com>  <489ecd0c0602192233y1cbd7d27s47755a14db115a79@mail.gmail.com> <20060219223944.1a70aee1.akpm@osdl.org> 
To: "Luke Yang" <luke.adi@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture --improved version 
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 20 Feb 2006 10:35:03 +0000
Message-ID: <5292.1140431703@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang <luke.adi@gmail.com> wrote:

> +#ifndef CONFIG_MMU
> +#define randomize_va_space 0
> +#else
>  extern int randomize_va_space;
> +#endif

Acked-By: David Howells <dhowells@redhat.com>
