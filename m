Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUBDSAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBDSAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:00:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:44943 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261827AbUBDSAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:00:49 -0500
Date: Wed, 4 Feb 2004 09:59:53 -0800
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 19/42]
Message-ID: <20040204175953.GA11614@kroah.com>
References: <Pine.LNX.4.58L.0402041516350.1299@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402041516350.1299@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hid-core.c:879: warning: implicit declaration of function `hiddev_report_event'
> 
> Add missing prototype in include/linux/hiddev.h

Thanks, I've added this to my 2.4 usb tree and will send to Marcelo
after 2.4.25 is out.

greg k-h
