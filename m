Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTFYPeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTFYPeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:34:14 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:29679 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264569AbTFYPeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:34:09 -0400
Subject: Re: pci_destroy_dev symbol when CONFIG_HOTPLUG is not set in 2.5.73
From: Martin Schlemmer <azarah@gentoo.org>
To: Nikita Melnikov <slkw@stud2.aanet.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625102907.GA23641@ku3>
References: <20030625102907.GA23641@ku3>
Content-Type: text/plain
Organization: 
Message-Id: <1056556477.5426.12328.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 25 Jun 2003 17:54:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 12:29, Nikita Melnikov wrote:
> 	If we don't have CONFIG_HOTPLUG make bzImage fails because it's
> impossible to find pci_destroy_dev symbol. So this patch fixes
> drivers/pci/hotplug.c.
> 

Should already be fixed in latest -bk.

-- 
Martin Schlemmer


