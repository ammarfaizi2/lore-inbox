Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCaG4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCaG4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 01:56:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261753AbUCaG4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 01:56:21 -0500
Message-ID: <406A6B87.801@pobox.com>
Date: Wed, 31 Mar 2004 01:56:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcus Hartig <m.f.h@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <406A5B6E.8050302@web.de>
In-Reply-To: <406A5B6E.8050302@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Hartig wrote:
> Hallo,
> 
> I did not get it work with my Maxtor SATA 80GB 6Y080M0.

Can you post the relevant 'dmesg' output?


> With 2.6.5-rc2/3 or mm1 no chance to get the higher request size. Is
> this not possible with the the smaller drives and libata? Im not
> sure if this disk has the the lba48 feature?

If it does not have lba48, then the patch should print out "request size 
128K" or similar.


> Abit NF7-S with an SilImage 3112a is here under Fedora
> running.

That should be fine with lba48...

	Jeff



