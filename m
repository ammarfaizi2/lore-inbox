Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUEQXp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUEQXp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUEQXpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:45:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263169AbUEQXnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:43:02 -0400
Message-ID: <40A94DF7.30307@pobox.com>
Date: Mon, 17 May 2004 19:42:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com>	<40A40204.1060509@pobox.com>	<40A93DA5.4020701@hp.com>	<20040517160508.63e1ddf0.akpm@osdl.org>	<20040517161212.659746db.akpm@osdl.org>	<40A94857.9030507@pobox.com> <20040517163356.506a9c8f.akpm@osdl.org>
In-Reply-To: <20040517163356.506a9c8f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It's only applicable to 32-bit machines.  I thik I'd prefer to let the
> various arch maintainers decide if this is an appropriate implementation.


Agreed, though I observe it's mostly 32-bit architectures that are 
missing readq() and writeq() implementations...

	Jeff



