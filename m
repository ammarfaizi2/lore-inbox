Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAEVOV>; Fri, 5 Jan 2001 16:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130559AbRAEVOL>; Fri, 5 Jan 2001 16:14:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:39175 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129747AbRAEVN6>;
	Fri, 5 Jan 2001 16:13:58 -0500
Date: Fri, 5 Jan 2001 22:13:27 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
Message-ID: <20010105221326.A10112@caldera.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0101051454230.2859-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0101051454230.2859-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jan 05, 2001 at 02:56:40PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 02:56:40PM -0200, Marcelo Tosatti wrote:
> > * VM: experiment with different active lists / aging pages
> >   of different ages at different rates + other page replacement
> >   improvements
> > * VM: Quality of Service / fairness / ... improvements
>   * VM: Use kiobuf IO in VM instead buffer_head IO. 

I'd vote for killing both bufer_head and kiobuf from VM.
Lokk at my pageio patch - VM doesn't know about the use of kiobufs
in the filesystem IO...

	Christoph
-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
