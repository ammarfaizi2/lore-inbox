Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263380AbTC2EvO>; Fri, 28 Mar 2003 23:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263381AbTC2EvO>; Fri, 28 Mar 2003 23:51:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263380AbTC2EvN>;
	Fri, 28 Mar 2003 23:51:13 -0500
Message-ID: <3E852901.7000903@pobox.com>
Date: Sat, 29 Mar 2003 00:02:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: xircom init_etherdev conversion.
References: <200303241642.h2OGg335008252@deviant.impure.org.uk>
In-Reply-To: <200303241642.h2OGg335008252@deviant.impure.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk wrote:
> - Also cleans up some exit paths.

...and now xircom_remove is kfree'ing memory that was never kmalloc'd

