Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbRFYR6L>; Mon, 25 Jun 2001 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265892AbRFYR6B>; Mon, 25 Jun 2001 13:58:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3592 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265890AbRFYR5w>;
	Mon, 25 Jun 2001 13:57:52 -0400
Date: Mon, 25 Jun 2001 14:57:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: John Fremlin <vii@users.sourceforge.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <m2d77s4m34.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.4.21.0106251456130.7419-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 2001, John Fremlin wrote:

> Last year I had the idea of tracing the memory accesses of the system
> to improve the VM - the traces could be used to test algorithms in
> userspace. The difficulty is of course making all memory accesses
> fault without destroying system performance.

Sounds like a cool idea.  One thing you should keep in mind
though is to gather traces of the WHOLE SYSTEM and not of
individual applications.

There has to be a way to balance the eviction of pages from
applications against those of other applications.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

