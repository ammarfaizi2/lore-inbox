Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTDYSoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDYSoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:44:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:28867 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261335AbTDYSoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:44:22 -0400
Date: Fri, 25 Apr 2003 11:58:32 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [proposition of drivers documentation]
Message-ID: <20030425185832.GA3543@kroah.com>
References: <3EA96F27.3090207@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EA96F27.3090207@wanadoo.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 07:23:51PM +0200, xosé vázquez pérez wrote:
> =CHANGELOG
> 
>  [Changelog]: (latest at top)
> 
>  [date] [version] or [modification #] [<e-mail@server.com>]
>  - bug fixes at makemelove()
>  ...

This starts to get very long over time, and quite messy, and pretty much
is pointless.  I used to do it for my drivers, but have given up due to
no one ever reading it, and the advent of bitkeeper (you can get
individual revision history for every file now quite easily.)

> =HARDWARE
> 
>  [Supported hardware]:
> 
>  [manufacturer_1]
>         [product name]
> 
>  [manufacturer_2]
>         [product name]
> 
> =END

This is already listed in the MODULE_DEVICE_TABLE and can be parsed
later by userspace tools quite easily.

thanks,

greg k-h
