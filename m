Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSA2Axv>; Mon, 28 Jan 2002 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSA2Axm>; Mon, 28 Jan 2002 19:53:42 -0500
Received: from mail120.mail.bellsouth.net ([205.152.58.80]:11899 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S288019AbSA2Axc>; Mon, 28 Jan 2002 19:53:32 -0500
Subject: Re: Rik van Riel's vm-rmap
From: Louis Garcia <louisg00@bellsouth.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201282214010.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201282214010.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 28 Jan 2002 19:56:56 -0500
Message-Id: <1012265817.4386.2.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, has anyone ported the latest patch to 2.4.18-pre7 yet??

--Louis


On Mon, 2002-01-28 at 19:15, Rik van Riel wrote:
> On 28 Jan 2002, Louis Garcia wrote:
> 
> > Should I do the rmap patch first?
> 
> Yes.
> 
> After that you can patch the low latency patch,
> which will give you a reject on vmscan.c
> 
> This doesn't matter because:
> 1) each part of the low latency patch is independant
> 2) -rmap already has low latency code in vmscan.c
> 
> kind regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 



