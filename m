Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUGNXNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUGNXNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGNXLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:11:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:42965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266013AbUGNXJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:37 -0400
Date: Wed, 14 Jul 2004 16:04:42 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH 2.6] Fix OOPS in device_platform_unregister
Message-ID: <20040714230442.GH3398@kroah.com>
References: <200407102213.39422.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407102213.39422.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 10:13:39PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> The following patch should fix the oops reported by Denis. We can safely
> move call to device_unregister as the release fucntion is not guaranteed
> to be called immediately and therefore should not access resources anyway.

Applied, thanks.

greg k-h
