Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266066AbRGCXou>; Tue, 3 Jul 2001 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266068AbRGCXok>; Tue, 3 Jul 2001 19:44:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56850 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266066AbRGCXod>;
	Tue, 3 Jul 2001 19:44:33 -0400
Date: Tue, 3 Jul 2001 20:44:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Ph. Marek" <marek@bmlv.gv.at>
Cc: <linux-kernel@vger.kernel.org>, <phillips@bonn-fries.net>
Subject: Re: Ideas for TUX2
In-Reply-To: <3.0.6.32.20010703082513.0091f900@pop3.bmlv.gv.at>
Message-ID: <Pine.LNX.4.33L.0107032042220.28737-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Ph. Marek wrote:

> If a file's data has been changed, it suffices to update the inode and the
> of free blocks bitmap (fbb).
> But updating them in one go is not possible

You seem to have missed some fundamental understanding of
exactly how phase tree works; the wohle point of phase
tree is to make atomic updates like this possible!

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

