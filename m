Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbRAGPp5>; Sun, 7 Jan 2001 10:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbRAGPpr>; Sun, 7 Jan 2001 10:45:47 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:60923 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129870AbRAGPpg>; Sun, 7 Jan 2001 10:45:36 -0500
Date: Sun, 7 Jan 2001 13:45:14 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 todo list update
In-Reply-To: <m1n1d3ifey.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0101071335070.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> 
> > The following bugs _could_ be fixed ... I'm not 100% certain
> > but they're probably gone (could somebody confirm/deny?):
> > 
> > * mm->rss is modified in some places without holding the
> >   page_table_lock
> 
> As of linux-2.4.0-test13-pre7 I can confirm that this bug still
> exists.  The most obvious location is in zap_page_range, there
> may be others as well.

Hmm, this is something we really want to check in 2.4.0.
Not a showstopper, but something we want to check anyway ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
