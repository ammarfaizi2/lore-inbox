Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRJSTmJ>; Fri, 19 Oct 2001 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278636AbRJSTl7>; Fri, 19 Oct 2001 15:41:59 -0400
Received: from [207.8.4.6] ([207.8.4.6]:9435 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S278633AbRJSTls>;
	Fri, 19 Oct 2001 15:41:48 -0400
Message-ID: <3BD08207.7090807@interactivesi.com>
Date: Fri, 19 Oct 2001 14:41:59 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Tyner <jtyner@cs.ucr.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Tyner wrote:

> Isn't this solved by just recompiling the kernel with HIGHMEM support?


I don't think so.  The Red Hat 7.1 kernel is compiled with "4GB" support, 
which apparently is the same as HIGHMEM.  We see the 890MB kernel vmalloc 
limit still.

