Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbSK3IaB>; Sat, 30 Nov 2002 03:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbSK3IaB>; Sat, 30 Nov 2002 03:30:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26378 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267223AbSK3IaB>;
	Sat, 30 Nov 2002 03:30:01 -0500
Date: Sat, 30 Nov 2002 00:28:54 -0800
From: Greg KH <greg@kroah.com>
To: Romain Lievin <rlievin@free.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb_bulk_msg returns EOVERFLOW
Message-ID: <20021130082854.GS17065@kroah.com>
References: <20021129135340.GA2561@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129135340.GA2561@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 02:54:10PM +0100, Romain Lievin wrote:
> Hi,
> 
> with kernel 2.4.20 , usb_bulk_msg returns EOVERFLOW in my tiglusb module.
> I never got this with previous kernels.
> What does it mean ?

See Documentation/usb/error-codes.txt for the possible reasons this
could be happening.  Why it's happening only in 2.4.20, I do not know.

greg k-h
