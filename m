Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268698AbRG3Wg6>; Mon, 30 Jul 2001 18:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRG3Wgh>; Mon, 30 Jul 2001 18:36:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:43021 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268675AbRG3Wgc>; Mon, 30 Jul 2001 18:36:32 -0400
Message-ID: <3B65E177.D77ACA45@namesys.com>
Date: Tue, 31 Jul 2001 02:36:39 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> On Tue, 31 Jul 2001, Hans Reiser wrote:
> > Christoph Hellwig wrote:
> 
> > > Nope.  It does a reiserfs_panic instead of letting the wrong arguments
> > > slipping into lower layers and possibly on disk and thus corrupting data.
> > >
> > > And in my opinion correct data is much more worth than one crash more or
> > > less (especially with a journaling filesystem).
> >
> > The cost is not a crash, the cost is performance sucks.
> 
> If you can chose between sucky performance or a chance
> at silent data corruption ... which would you chose ?
> 
> Rik
> --
> Executive summary of a recent Microsoft press release:
>    "we are concerned about the GNU General Public License (GPL)"
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com/


If you could halve linux memory manager performance and check as many things as
reiserfs checks, would you do it.  I think not, or else you would have.  You
made the right choice.  Now, if you add a #define, you can check as many things
as ReiserFS checks, and still go just as fast....

Hans
