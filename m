Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUCEJiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUCEJiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:38:09 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:49062 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262284AbUCEJiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:38:07 -0500
Message-ID: <40484643.7070104@cyberone.com.au>
Date: Fri, 05 Mar 2004 20:20:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kyle Wong <kylewong@southa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: questions about io scheduler
References: <088201c40293$5b27ce80$9c02a8c0@southa.com>
In-Reply-To: <088201c40293$5b27ce80$9c02a8c0@southa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kyle Wong wrote:

>1. Is  anticipatory io scheduler + echo 0 >
>/sys/block/hd*/queue/iosched/antic_expire = deadline scheduler?
>
>

It is very similar but not quite the same.

>2. Does io scheduler works with md RAID? Correct me if I'm wrong,
>io-schedular <-->  md driver <--> harddisks.
>
>

It goes md driver -> io schedulers -> hard disks.

