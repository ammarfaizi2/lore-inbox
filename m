Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUFUDhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUFUDhC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265997AbUFUDhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:37:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266002AbUFUDgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:36:54 -0400
Message-ID: <40D657B7.8040807@pobox.com>
Date: Sun, 20 Jun 2004 23:36:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-bk way too fast
References: <40D64DF7.5040601@pobox.com>
In-Reply-To: <40D64DF7.5040601@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Something is definitely screwy with the latest -bk.  I updated from a 
> kernel ~1 week ago, and all timer-related stuff is moving at a vastly 
> increased rate.  My guess is twice as fast.  Most annoying is the system 
> clock advances at twice normal rate, and keyboard repeat is so sensitive 
> I am spending quite a bit of time typing this message, what with having 
> to delettte (<== example) extra characters.  Double-clicking is also 
> broken :(

Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset now...

	Jeff


