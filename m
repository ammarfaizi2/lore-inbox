Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWC3D0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWC3D0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWC3D0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:26:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWC3D0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:26:35 -0500
Date: Wed, 29 Mar 2006 19:26:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Spitalnik <jan@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI assign-busses
Message-Id: <20060329192616.4644963e.akpm@osdl.org>
In-Reply-To: <200603300223.13530.jan@spitalnik.net>
References: <200603300223.13530.jan@spitalnik.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Spitalnik <jan@spitalnik.net> wrote:
>
> while playing with 2.6.16-git kernel from today, I've found out following 
>  message in dmesg:
> 
>  PCI: Bus #04 (-#07) is hidden behind transparent bridge #02 (-#04) 
>  (try 'pci=assign-busses')
> 
>  My notebook is HP nc6120 (Pent-M, ICH6). So i've rebooted with said parameter 
>  and dmesg changed a bit, finding new "resources" (not sure what's the proper 
>  terminology :)

Did everything actually work OK when pci=assign-busses was not used?
