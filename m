Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269717AbUINTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269717AbUINTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269714AbUINTYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:24:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:26830 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269727AbUINTMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:12:36 -0400
Date: Tue, 14 Sep 2004 12:04:20 -0700
From: Greg KH <greg@kroah.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] - remove ugly code from usb/serial/usb-serial.c.
Message-ID: <20040914190420.GB21135@kroah.com>
References: <20040913184350.44788366.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913184350.44788366.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 06:43:50PM -0300, Luiz Fernando N. Capitulino wrote:
> 
>  Greg,
> 
>  This patch removes ugly code from some function in usb/serial/usb-serial.c
> which is using a goto statement intead of a simple `return'.
> 
>  To be true, I'm not certain if there is a special reason to do that, if so
> ignore me. ;)

No, that's a hold over from a fix a long time ago that got rid of some
locks that used to be freed in the exit code.

Thanks for the patch, I've applied it to my trees.

greg k-h
