Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317163AbSEXTEj>; Fri, 24 May 2002 15:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317166AbSEXTEi>; Fri, 24 May 2002 15:04:38 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:26365 "EHLO fep3.cogeco.net")
	by vger.kernel.org with ESMTP id <S317163AbSEXTEg>;
	Fri, 24 May 2002 15:04:36 -0400
Subject: Re: Reset PCI card
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3CEE2670.4010701@p4all.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 24 May 2002 15:04:34 -0400
Message-Id: <1022267074.27864.4.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 07:39, Michael Dunsky wrote:
> Hi!
> 
> The "svgalib" has a tool named "reset_vga". It completely resets your
> VGA-card . You may try it... but it's only a workaround at the cause and 
> not at the symptom.

That package doesn't have a nice automake/autconf installer, so I didn't
run across the reset_vga thingy at first.  I did, however, make it work
with mode3:

1. SSH in
2. init 3
3. mode3
4. init 5
5. Close SSH
6. Walk over to the box
7. Log into all the text mode ttys (tty[1-6]), type "clear" and log out.

You're right though.  This shouldn't be happening in the first place.

> 
> I used it a longer time ago with a similar problem (only slightly 
> similar - programmed the VGA-card "by hand", and needed to clear the 
> scrambled output I produced :-) ).
> 
> ciao
> 
> Michael
> 
> 
> Nix N. Nix wrote:
>  > The symptom:
>  >
>  > Sometimes, when I switch between virtual terminals, (away from X ==
>  > tty7), instead of getting my usual login prompt, the picture I've had
>  > during my X session (or the picture of the display manager) stays on
>  > the screen, albeit with some of the colours screwed up (as if it were
>  > a 256 colour palette-based display, even though it's 24 bit colour -
>  > you know, like in Windows, when you have 256 colours and you switch
>  > from one app to another and the colours in your background picture get
>  > all frelled up).  The terminal does switch over to the appropriate tty
>  > because I can log in and type whatever (blindly though) and it does
>  > work.
>  >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Thanks for all the help.

