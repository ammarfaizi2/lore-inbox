Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUC2STU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUC2STU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:19:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263039AbUC2STR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:19:17 -0500
Message-ID: <40686896.3000402@pobox.com>
Date: Mon, 29 Mar 2004 13:19:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de>
In-Reply-To: <20040329080943.GR24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't care how the implementation looks.  The most basic points are 
that driver writers should not have to care about the value of this 
1M-max-request-size magic number, nor is it in any way specific to SATA.

	Jeff




