Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRHTRDQ>; Mon, 20 Aug 2001 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271430AbRHTRDG>; Mon, 20 Aug 2001 13:03:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53772 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271421AbRHTRC5>; Mon, 20 Aug 2001 13:02:57 -0400
Date: Mon, 20 Aug 2001 14:02:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Benjamin Redelings I <bredelin@ucla.edu>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <3B813743.5080400@ucla.edu>
Message-ID: <Pine.LNX.4.33L.0108201402140.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Benjamin Redelings I wrote:

> Was it really true, that swapped in pages didn't get marked as
> referenced before?

That's just an artifact of the use-once patch, which
only sets the referenced bit on the _second_ access
to a page.

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

