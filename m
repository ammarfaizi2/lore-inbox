Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUKHM12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUKHM12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKHM12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:27:28 -0500
Received: from wpkrenn.net ([217.114.210.79]:14600 "EHLO
	217-114-210-79.wpkrenn.net") by vger.kernel.org with ESMTP
	id S261818AbUKHM1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:27:25 -0500
Message-ID: <418F661E.6050601@gmx.at>
Date: Mon, 08 Nov 2004 13:27:10 +0100
From: Willibald Krenn <Willibald.Krenn@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.4.2) Gecko/20040921
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VMM:  syscall for reordering pages in vm
References: <418F4F97.5000805@gmx.at> <1099915498.3577.7.camel@laptop.fenrus.org>
In-Reply-To: <1099915498.3577.7.camel@laptop.fenrus.org>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
> On Mon, 2004-11-08 at 11:51 +0100, Willibald Krenn wrote:
>> virtual memory page exchange by modifying the physical<->virtual
>>page mapping. 
> 
> eh isn't this already possible with mmap and mremap ?

If I'm not mistaken: You can not tell mmap and mremap to explicitely 
exchange two pages. (Mremap resizes an existing memory mapping.)

Perhaps I did not explain my idea good enough: I want something along 
the lines "Current memory contents in page starting at address X move to 
address Y and the contents of the page starting at address Y shall be 
found at address X in future".

