Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUIKRFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUIKRFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIKRFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:05:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:55463 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268203AbUIKRFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:05:37 -0400
Message-ID: <41433059.7030006@suse.de>
Date: Sat, 11 Sep 2004 19:05:29 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: progress in percent
References: <20040910084704.GB12751@elf.ucw.cz> <20040911130324.GB14771@thundrix.ch>
In-Reply-To: <20040911130324.GB14771@thundrix.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

>>-	printk(" %d Pages done.\n",i);
>>+	printk("\b\b\b\bdone\n");
> 
> Didn't we say we want the page count here?

well, you usually won't see it anyway since after writing the pages to
swap the machine should power off pretty soon :-)
Changing it to

	printk("\b\b\b%d Pages done.\n",i);

is no big deal though.

	Stefan
