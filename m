Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRAESsk>; Fri, 5 Jan 2001 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRAESsa>; Fri, 5 Jan 2001 13:48:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:56326 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130188AbRAESsT>; Fri, 5 Jan 2001 13:48:19 -0500
Date: Fri, 5 Jan 2001 14:56:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051454230.2859-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Rik van Riel wrote:

> Probably 2.5 era:
> * VM: physical->virtual reverse mapping, so we can do much
>   better page aging with less CPU usage spikes 
> * VM: move all the global VM variables, lists, etc. into the
>   pgdat struct for better NUMA scalability
> * VM: per-node kswapd for NUMA
> * VM: thrashing control, maybe process suspension with some
>   forced swapping ?             (trivial only in theory)
> * VM: experiment with different active lists / aging pages
>   of different ages at different rates + other page replacement
>   improvements
> * VM: Quality of Service / fairness / ... improvements
  * VM: Use kiobuf IO in VM instead buffer_head IO. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
