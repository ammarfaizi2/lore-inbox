Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUGNHt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUGNHt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 03:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUGNHt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 03:49:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265847AbUGNHty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 03:49:54 -0400
Message-ID: <40F4E58F.7040204@pobox.com>
Date: Wed, 14 Jul 2004 03:49:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Takao Indoh <indou.takao@soft.fujitsu.com>,
       lkcd-devel@lists.sourceforge.net
Subject: Re: [RFC] Standard filesystem types for crash dumping
References: <11077.1089790663@kao2.melbourne.sgi.com>
In-Reply-To: <11077.1089790663@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Follow ups to lkml please, to keep any discussion on the same list.
> 
> Several kernel additions exist for saving crash dump information, among
> them are lkcd, crash, kmsgdump.  They all have the same problems :-
> 
> * Where to store the crash data.
> * How to write data when the kernel is unreliable, it may not be
>   servicing interrupts.
> * User space needs to read and clear the dump data.
> * Performance!
> * Coexistence of multiple dump drivers.


Have you tried diskdump?

It already exists, and seems to address these things.

	Jeff


