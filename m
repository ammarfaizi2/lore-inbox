Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272188AbRIEOgY>; Wed, 5 Sep 2001 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272191AbRIEOgP>; Wed, 5 Sep 2001 10:36:15 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:2061 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S272188AbRIEOf6>; Wed, 5 Sep 2001 10:35:58 -0400
To: Michael Bacarella <mbac@nyct.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de>
	<20010905093851.A24280@sync.nyct.net>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 16:35:41 +0200
In-Reply-To: <20010905093851.A24280@sync.nyct.net> (Michael Bacarella's message of "Wed, 5 Sep 2001 09:38:51 -0400")
Message-ID: <tgsne1vh6q.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bacarella <mbac@nyct.net> writes:

> There's no need. The equivalent functionality can already be
> implemented in userspace.

Well, it doesn't work with TCP.  Uh-oh, I see I forgot to mention the
following: I need this functionality for local TCP connections, not
just UNIX domain sockets.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
