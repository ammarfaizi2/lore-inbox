Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUEAFvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUEAFvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEAFvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:51:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:30100 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261992AbUEAFvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:51:39 -0400
Date: Fri, 30 Apr 2004 22:48:04 -0700
From: Greg KH <greg@kroah.com>
To: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040501054804.GH21431@kroah.com>
References: <20040429120250.GD10867@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429120250.GD10867@gonzo.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:02:50PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> +	if ( !buf || !client ) {

Can you clean up your exuberant use of spaces in 'if' statements, and
function calls?  It's not the proper kernel style.

> +DONE:

Lowercase please

> +	if ( ret ) {
> +		if ( d ) kfree( d );

No need to check a pointer before sending it to kfree.

thanks,

greg k-h
