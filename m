Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVBXGzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVBXGzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBXGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:55:31 -0500
Received: from isilmar.linta.de ([213.239.214.66]:22744 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261826AbVBXGz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:55:28 -0500
Date: Thu, 24 Feb 2005 07:55:27 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [8/14] Orinoco driver updates - PCMCIA initialization cleanups
Message-ID: <20050224065527.GA8931@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040052.GJ32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -184,6 +186,7 @@
>  	dev_list = link;
>  
>  	client_reg.dev_info = &dev_info;
> +	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;

That's not needed any longer for 2.6.

	Dominik
