Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVGHTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVGHTin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVGHTgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:36:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:45227 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262811AbVGHTeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:34:02 -0400
Date: Fri, 8 Jul 2005 12:33:57 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Message-ID: <20050708193357.GC2228@kroah.com>
References: <20050709001657.GA29556@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709001657.GA29556@abhays.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong Subject:  :(

> +struct platform_device *rbu_device;
> +int context;

These should not be global variables.

You also have some functions that are global, please fix them.

thanks,

greg k-h
