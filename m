Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRHSWRA>; Sun, 19 Aug 2001 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270817AbRHSWQu>; Sun, 19 Aug 2001 18:16:50 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:11356 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S270819AbRHSWQl>; Sun, 19 Aug 2001 18:16:41 -0400
Message-ID: <3B803AAD.4030505@blue-labs.org>
Date: Sun, 19 Aug 2001 18:16:13 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010817
X-Accept-Language: en-us
MIME-Version: 1.0
To: otto.wyss@bluewin.ch
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk waiting  time)
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mount your floppy synchronous.  Writes won't be buffered then.

David

Otto Wyss wrote:

>I recently wrote some small files to the floppy disk and noticed almost nothing
>happened immediately but after a certain time the floppy actually started
>writing. So this action took more than 30 seconds instead just a few. This
>remembered me of the elevator problem in the kernel. To transfer this example
>into real live: A person who wants to take the elevator has to wait 8 hours
>before the elevator even starts. While probably everyone agrees this is
>ridiculous in real live astonishingly nobody complains about it in case of a disk.
>


