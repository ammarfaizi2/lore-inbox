Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVAGCXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVAGCXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAGCXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:23:20 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:23823 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbVAGCUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:20:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FfuHze17Cgj3UnPO9Du2X32fUCZbTanN9/muLRSEOAvOCUzvHwqvjwl9OXWVdj4KfiwBXbzzeRNIVYrWLlZu6s/KeIC2iMfmqGpWXp9LLKi0xph17/C7xP7x8rXmUSfMXFWxs0KqMTInvIouLFCxP3A2Ec3UbEc0QxHw++hWlpc=
Message-ID: <58cb370e050106182095af5a6@mail.gmail.com>
Date: Fri, 7 Jan 2005 03:20:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ide] clean up error path in do_ide_setup_pci_device()
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1104854560.17176.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412310343.iBV3hqvd015595@hera.kernel.org>
	 <1104773262.13302.3.camel@localhost.localdomain>
	 <58cb370e050103142269e1f67f@mail.gmail.com>
	 <1104788671.13302.63.camel@localhost.localdomain>
	 <20050104001454.GA7655@electric-eye.fr.zoreil.com>
	 <1104854560.17176.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all pci_disable_device() calls removed for now
