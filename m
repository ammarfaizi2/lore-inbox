Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268906AbVBFCXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268906AbVBFCXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269074AbVBFCXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:23:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28585 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S269315AbVBFCXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 21:23:14 -0500
Message-ID: <42057F83.1020807@pobox.com>
Date: Sat, 05 Feb 2005 21:22:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA in 2.4 at PE750
References: <20050203135829.319d3b69@localhost.localdomain> <20050204114514.4ae7ef2a@localhost.localdomain>
In-Reply-To: <20050204114514.4ae7ef2a@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Jeff, you're allocating a block of two probe entries with a signle kmalloc
> then freeing halfs of it with two kfrees.

fix applied to 2.4 and 2.6


