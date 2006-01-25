Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWAYWu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWAYWu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAYWu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:50:59 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:52909 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S932202AbWAYWu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:50:58 -0500
Message-ID: <43D800CC.4090901@nortel.com>
Date: Wed, 25 Jan 2006 16:50:52 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] make it easy to test new kernels
References: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
In-Reply-To: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2006 22:50:54.0215 (UTC) FILETIME=[CC286970:01C62201]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:

> Now, will all these talks about virtualization, I wonder if it will be
> possible one day to just download a new virtualized test OS and test
> it without rebooting the main one. I could always allocate 10 G to a
> test system on my disk. As long as I don't have to reboot.

A large portion of kernel issues are found in the hardware support, 
which is difficult to test in a virtualized environment.

However, something like this could ensure that the APIs handle random 
garbage, that POSIX works properly, etc...

Chris
