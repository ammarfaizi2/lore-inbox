Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTKSKvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTKSKvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:51:22 -0500
Received: from linux-bt.org ([217.160.111.169]:26577 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264009AbTKSKvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:51:19 -0500
Subject: Re: test9 and bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200311190052.45803.cova@ferrara.linux.it>
References: <200311021853.47300.cova@ferrara.linux.it>
	 <200311062240.38099.cova@ferrara.linux.it>
	 <20031106231545.GN3345@conectiva.com.br>
	 <200311190052.45803.cova@ferrara.linux.it>
Content-Type: text/plain
Message-Id: <1069239043.4883.125.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 11:50:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> When the dongle is inserted, I can see this on syslog:
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f75dd814 err -90
> 
> ..or this:
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f71f7c14 err -22
> 
> 
> Hope this can shed some light; I can made any test needed to narrow down this 
> issue, just let me know.

another thing to try is to disable the SCO support of the HCI USB driver
and in this case it don't uses ISOC transfers.

Regards

Marcel


