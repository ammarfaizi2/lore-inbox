Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSK3Xom>; Sat, 30 Nov 2002 18:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSK3Xom>; Sat, 30 Nov 2002 18:44:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261330AbSK3Xol>;
	Sat, 30 Nov 2002 18:44:41 -0500
Message-ID: <3DE94F07.5000904@pobox.com>
Date: Sat, 30 Nov 2002 18:51:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: acc@cs.stanford.edu
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 16 more potential buffer overruns in 2.5.48
References: <20021120084934.GA24014@Xenon.stanford.edu>
In-Reply-To: <20021120084934.GA24014@Xenon.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chou wrote:
> [BUG] Hw imposed bound?
> /u1/acc/linux/2.5.48/drivers/net/3c515.c:553:corkscrew_scan: 
> ERROR:BUFFER:553:553:Array bounds error: options[8] indexed with [8]


yep, that's a bug (if an extremely unlikely one). thanks, fixed.

