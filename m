Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVKHBQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVKHBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVKHBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:16:56 -0500
Received: from gambit.vianw.pt ([195.22.31.34]:2004 "EHLO gambit.vianw.pt")
	by vger.kernel.org with ESMTP id S965040AbVKHBQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:16:56 -0500
Message-ID: <436FFC7F.6040207@esoterica.pt>
Date: Tue, 08 Nov 2005 01:16:47 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Accessing file mapped data inside the kernel (newbie Q.)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

How do I access the data and its length mapped to a file
after returning from generic_file_mmap(file,vma) inside
the kernel?
How about more than one page?

int <A_FILESYSTEM_NAME (ext3 for ex.)>_file_mmap(struct file * file, 
struct vm_area_struct * vma)
{
    int addr;
    addr=generic_file_mmap(file,vma);
    ?????
    return addr;
}

Thanks

