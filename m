Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRAEUfo>; Fri, 5 Jan 2001 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRAEUfe>; Fri, 5 Jan 2001 15:35:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:62214 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130355AbRAEUfT>; Fri, 5 Jan 2001 15:35:19 -0500
Date: Fri, 5 Jan 2001 16:43:28 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0101051827440.1295-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051642260.2882-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2001, Rik van Riel wrote:

> Also, you do not want the writer to block on writing out buffers
> if bdflush could write them out asynchronously while the dirty
> buffer producer can work on in the background.

flush_dirty_buffers() do not wait on the buffers written to get clean.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
