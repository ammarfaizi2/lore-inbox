Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUDOTIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUDOTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:08:24 -0400
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:24012 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262316AbUDOTHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:07:43 -0400
Message-ID: <407EDD23.3080009@stesmi.com>
Date: Thu, 15 Apr 2004 21:06:11 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
References: <20040415171755.GC3218@logos.cnet>
In-Reply-To: <20040415171755.GC3218@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Hi, 
> 
> Jeff Garzik sent me a SATA update to be merged in 2.4.x. 
> 
> A lot of new boxes are shipping with SATA-only disks, and its pretty bad
> to not have a "stable" series without such industry-standard support.
> 
> This is the last feature to be merged on 2.4.x, and only because its quite 
> necessary.
> 
> Any oppositions?

There are alternative ways* to get sata support for some chips but I
believe it's the right choice to do the 'full' route so I believe it's
the right choice. 2.4 will still be used for quite a while, especially
until "everybody" trusts 2.6, same way that happened with 2.2 and 2.4 ..

* siimage.c, add sata8237 entry to via driver, etc...

// Stefan
