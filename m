Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276331AbRJHPGy>; Mon, 8 Oct 2001 11:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276917AbRJHPGo>; Mon, 8 Oct 2001 11:06:44 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:43194 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S276331AbRJHPGc>;
	Mon, 8 Oct 2001 11:06:32 -0400
Date: Mon, 08 Oct 2001 16:08:43 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <1231676407.1002557323@[10.132.113.67]>
In-Reply-To: <E15qLzV-00071D-00@the-village.bc.nu>
In-Reply-To: <E15qLzV-00071D-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, October 07, 2001 11:01 PM +0100 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> vmalloc space fragments. You fragment address space rather than pages
> thats all. Same problem

Actually fragmented virtual space is theoretically
worse, as you have now lost a possible weapon to
defragment stuff (indirection on mapping to physical RAM -
i.e. you could no longer move or swap out physical RAM and
keep the virtual address mapping the same).

--
Alex Bligh
