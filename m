Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315823AbSENQgQ>; Tue, 14 May 2002 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315838AbSENQgP>; Tue, 14 May 2002 12:36:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38153 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315823AbSENQgN>; Tue, 14 May 2002 12:36:13 -0400
Date: Tue, 14 May 2002 13:36:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <20020514153956.GI15756@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0205141335080.9490-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, William Lee Irwin III wrote:
> On Mon, May 13, 2002 at 10:19:26PM -0300, Rik van Riel wrote:
> > 2) if no process is running, the timer interrupt adds a jiffy
> >    to the iowait time
> [...]
> > 4) on SMP systems the iowait time can be overestimated, no big
> >    deal IMHO but cheap suggestions for improvement are welcome
                     ^^^^^
> This appears to be global across all cpu's. Maybe nr_iowait_tasks
> should be accounted on a per-cpu basis, where

While your proposal should work, somehow I doubt it's worth
the complexity. It's just a statistic to help sysadmins ;)

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

