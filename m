Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSAFT2J>; Sun, 6 Jan 2002 14:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSAFT2A>; Sun, 6 Jan 2002 14:28:00 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:45530 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289011AbSAFT1y>; Sun, 6 Jan 2002 14:27:54 -0500
Message-ID: <3C38A526.2050309@acm.org>
Date: Sun, 06 Jan 2002 20:27:34 +0100
From: Laurent Guerby <guerby@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <E16NGKQ-0005ky-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In the Linux case mmio isn't a problem. The rules for mmio in the portable
> code require you use architecture dependant macros (readb etc) and that
> the mmio space is mapped via ioremap.


I haven't done my homework, but I assume the code behind readb use inline
assembly and not C on most platforms?

May be GNU C could get some of the idea behind the Linux macros
to define the needed extension (portable within GNU C architectures
wherever possible).

-- 
Laurent Guerby <guerby@acm.org>

