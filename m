Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269714AbUINTY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269714AbUINTY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269712AbUINTXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:23:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:26574 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269726AbUINTMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:12:36 -0400
Date: Tue, 14 Sep 2004 12:04:31 -0700
From: Greg KH <greg@kroah.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] - missing check in usb/serial/usb-serial.c.
Message-ID: <20040914190431.GC21135@kroah.com>
References: <20040913184339.7afb744c.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913184339.7afb744c.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 06:43:39PM -0300, Luiz Fernando N. Capitulino wrote:
> 
>  Hi Greg,
> 
>  This patch add a missing check in the call to bus_register() and
> not initialise `result' (which is not necessary).

Applied, thanks.

greg k-h
