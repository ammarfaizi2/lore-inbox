Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278383AbRJWXfT>; Tue, 23 Oct 2001 19:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278384AbRJWXfI>; Tue, 23 Oct 2001 19:35:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12039 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278383AbRJWXe4>;
	Tue, 23 Oct 2001 19:34:56 -0400
Date: Tue, 23 Oct 2001 21:35:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Issue with max_threads (and other resources) and highmem
In-Reply-To: <3BD5FD98.1AACC12D@kegel.com>
Message-ID: <Pine.LNX.4.33L.0110232134470.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Dan Kegel wrote:
> Rik wrote:
> > ... A sane upper limit for
> > max_threads would be 10000, this also keeps in mind the
> > fact that we only have 32000 possible PIDs, some of which
> > could be taken by task groups, etc...
>
> ?  I thought the 2.4 kernel had switched to 32 bit pid's long ago.
> Where does the limit of 32000 possible PIDs come from?

Please take a look at kernel/fork.c::get_pid() ...

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

