Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbRGCOwA>; Tue, 3 Jul 2001 10:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRGCOvu>; Tue, 3 Jul 2001 10:51:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2830 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264489AbRGCOva>; Tue, 3 Jul 2001 10:51:30 -0400
Date: Tue, 3 Jul 2001 11:51:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Guillaume Lancelin <guillaumelancelin@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory access
Message-ID: <20010703115118.B1616@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Guillaume Lancelin <guillaumelancelin@yahoo.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010703144532.11007.qmail@web4201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010703144532.11007.qmail@web4201.mail.yahoo.com>; from guillaumelancelin@yahoo.es on Tue, Jul 03, 2001 at 04:45:32PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 03, 2001 at 04:45:32PM +0200, Guillaume Lancelin escreveu:
> Writing a device driver for a IO card, I have the following message from
> the kernel:
> Unable to handle kernel paging request at virtual address 000d0804.
> [then it gives the register values]
> Segmentation fault."
> 
> This address (0xd0804) is the location of a "mailbox" reserved by the IO
> card, and from which commands are passed to the card.
> 
> My question: is the kernel using or protecting this area of the memory,
> and is there a way to deprotect it??? (how dangerous!)

are you accessing it directly? read Documentation/IO-mapping.txt

- Arnaldo
