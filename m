Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTDICUw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDICUw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:20:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261387AbTDICUv (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 22:20:51 -0400
Message-ID: <3E938630.7070001@pobox.com>
Date: Tue, 08 Apr 2003 22:32:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
References: <20030409015058.9EF0D2C08F@lists.samba.org>
In-Reply-To: <20030409015058.9EF0D2C08F@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3E925292.8060104@pobox.com> you write:
> 
>>You may take a look at "kcompat" for further examples. 
>>http://sf.net/projects/gkernel/   I provide an example of how to get a 
>>net driver from 2.4 running under 2.2, such that the 2.4 driver 
>>-appears- to be completely free of compatibility glue.
> 
> 
> Interesting.  How is this related to the older linux/compatmac.h?


It's not related at all to compatmac.h, though there are no doubt 
duplicate definitions in there.  This is mainly my own code, plus 
tytso's (serial.c), plus Donald Becker's.


> Have you thought of actually integrating a 2.4<->2.6 version once
> 2.6.0 is out?

Oh, I would love to have such items in there...   I take patches, and no 
need to wait for 2.6 either :)

	Jeff



