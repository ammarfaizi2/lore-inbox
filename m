Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbRB0TqB>; Tue, 27 Feb 2001 14:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129795AbRB0Tpl>; Tue, 27 Feb 2001 14:45:41 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:16635 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129781AbRB0Tpc>; Tue, 27 Feb 2001 14:45:32 -0500
Date: Tue, 27 Feb 2001 16:46:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102271109300.927-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0102271644350.5502-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Mike Galbraith wrote:

> Attempting to avoid doing I/O has been harmful to throughput here
> ever since the queueing/elevator woes were fixed. Ever since then,
> tossing attempts at avoidance has improved throughput markedly.
>
> IMHO, any patch which claims to improve throughput via code deletion
> should be worth a little eyeball time.. and maybe even a test run ;-)
>
> Comments welcome.

Before even thinking about testing this thing, I'd like to
see some (detailed?) explanation from you why exactly you
think the changes in this patch are good and how + why they
work.

IMHO it would be good to not apply ANY code to the stable
kernel tree unless we understand what it does and what the
author meant the code to do...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

