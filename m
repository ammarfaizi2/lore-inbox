Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUEZRWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUEZRWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbUEZRWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:22:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25834 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265742AbUEZRWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:22:25 -0400
Message-ID: <40B4D243.5030500@pobox.com>
Date: Wed, 26 May 2004 13:22:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: nforce2 keeps crashing with 2.4.27pre3
References: <200405261756.35333.cleanerx@au.hadiko.de> <40B4C4D4.8070100@pobox.com> <20040526191619.B6244@electric-eye.fr.zoreil.com>
In-Reply-To: <20040526191619.B6244@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>Driver bugs...  r8169 needs updating.
> 
> 
> Do you have a specific option in mind:
> - simple 2.6.6 backport (no napi nor ethtool support);
> - netdev backport (2.6.6 + napi)
> - new wave (2.6.6 + napi + ethtool/link/TBI rework)


I prefer to have the 2.4 and 2.6 drivers as close as possible to each 
other, to reduce the maintenance burden.

If the mainline r8169.c looks stable, then I would take that source and 
backport it to 2.4.x.

	Jeff


