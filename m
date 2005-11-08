Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVKHRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVKHRSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVKHRSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:18:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:63717 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030275AbVKHRSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:18:16 -0500
Date: Tue, 8 Nov 2005 09:17:37 -0800
From: Greg KH <greg@kroah.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: fix bound check IDT gate
Message-ID: <20051108171737.GA14092@kroah.com>
References: <4370E56D.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370E56D.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:50:37PM +0100, Jan Beulich wrote:
> Other than apparently commonly assumed, the bound instruction does not
> require the corresponding IDT entry to have DPL 3.
> 
> From: Jan Beulich <jbeulich@novell.com>

Shouldn't this be "Signed-off-by:" instead?

> (actual patch attached)

Can you put it in-line?

thanks,

greg k-h
