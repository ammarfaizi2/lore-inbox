Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVBXEnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVBXEnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVBXEjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:39:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43147 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261809AbVBXEfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:35:32 -0500
Message-ID: <421D5979.5080600@pobox.com>
Date: Wed, 23 Feb 2005 23:35:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
CC: Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [6/14] Orinoco driver updates - cleanup PCI initialization
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain>
In-Reply-To: <20050224035957.GH32001@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, pci_set_drvdata() needs to be one of the last functions called 
during PCI ->probe().

	Jeff



