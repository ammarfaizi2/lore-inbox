Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQJ0SHF>; Fri, 27 Oct 2000 14:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQJ0SGz>; Fri, 27 Oct 2000 14:06:55 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:26617 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129061AbQJ0SGm>; Fri, 27 Oct 2000 14:06:42 -0400
Date: Fri, 27 Oct 2000 16:06:23 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Somewhat different GPL Question
In-Reply-To: <39F9C1C7.BDEFE414@nortelnetworks.com>
Message-ID: <Pine.LNX.4.21.0010271604360.25174-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Christopher Friesen wrote:

> If I use some GPL'd code and make calls from my software to the
> GPL'd code, do I need to make *my* code available?  Or would I
> only have to make available any changes to the GPL'd code?
>
> Section 2.b of the GPL seems to indicate that I need to make the
> source for my entire executable available if it incorporates any
> GPL'd source, and that I cannot charge for the software, only
> for its distribution.  Is this correct?

It depends.

If you're making interprocess calls to call the GPL code,
I suspect you won't have to make your code GPL.

OTOH, if you /link/ against a GPL shared library, you will
have to GPL the source of your program (that is, you'll have
to give it to the people who receive the binary from you).

Mind that lots of the "system" libraries are under the
somewhat more free LPGL...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
