Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276863AbRJHMET>; Mon, 8 Oct 2001 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276864AbRJHMEJ>; Mon, 8 Oct 2001 08:04:09 -0400
Received: from ns.ithnet.com ([217.64.64.10]:11270 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276863AbRJHMEA>;
	Mon, 8 Oct 2001 08:04:00 -0400
Date: Mon, 8 Oct 2001 14:04:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: kladit@t-online.de (Klaus Dittrich)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11.p4 and dd
Message-Id: <20011008140422.0ed9eaa0.skraw@ithnet.com>
In-Reply-To: <20011007203540.A392@df1tlpc.local.here>
In-Reply-To: <20011007203540.A392@df1tlpc.local.here>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001 20:35:40 +0200 kladit@t-online.de (Klaus Dittrich) wrote:

> dd does not work anymore.
> 
> dd if=/dev/sda of=/dev/sdb bs=1024k 
> 
> stops with "File size limit exceeded"
> 
> Using kernel 2.4.3 the same command works fine.
> 
> 2.4.3 uses a large amount of buffer, 2.4.11p4 only chache.
> 2.4.3 doesn't swap, 2.4.11p4 eats up 1 GB RAM and 100 MB swap.

Please try 2.4.11-pre5.
pre4 is seriously broken regarding high vm loads.

Regards,
Stephan

