Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVEaQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEaQhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVEaQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:34:47 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:11856 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261970AbVEaQ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:29:24 -0400
Message-ID: <429C90DE.3000106@tls.msk.ru>
Date: Tue, 31 May 2005 20:29:18 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
References: <20050531124659.GB1530@suse.de> <429C86AD.4050605@pobox.com>
In-Reply-To: <429C86AD.4050605@pobox.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
[]
>  
>  struct ahci_host_priv {
>  	unsigned long		flags;
> +	unsigned int		have_msi; /* is PCI MSI enabled? */

BTW, can `have_msi' be just another bit in the `flags' field?

/mjt
