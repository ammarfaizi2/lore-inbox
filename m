Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSKCUbl>; Sun, 3 Nov 2002 15:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSKCUbj>; Sun, 3 Nov 2002 15:31:39 -0500
Received: from smtp.terra.es ([213.4.129.130]:43729 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S262728AbSKCUbf>;
	Sun, 3 Nov 2002 15:31:35 -0500
Date: Sun, 3 Nov 2002 21:38:24 +0100
From: Arador <diegocg@teleline.es>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: jgarzik@pobox.com, josh@stack.nl, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Petition against kernel configuration options madness...
Message-Id: <20021103213824.03391351.diegocg@teleline.es>
In-Reply-To: <20021103200704.A8377@ucw.cz>
References: <200211031809.45079.josh@stack.nl>
	<3DC56270.8040305@pobox.com>
	<20021103200704.A8377@ucw.cz>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 20:07:05 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> Too bad you don't have any suggestions. I completely agree this should
> be simplified, while I wouldn't be happy to lose the possibility of not
> compiling AT keyboard support in.


What about:

<*> serial i/o (mouse, keyboard...) support"
  <*> PC PS/2 and keyboard controller (i8042)
    <*> PS/2 mouse support
    <*> Typical (AT) keyboard support 
  <*> Serial port (COM) <something> support
    <*> Serial port (COM) mouse support
  [*] Advanced keyboard support
    <*> Other keyboards here
  <*> [the other Things]

Yes, it confuses people who only wants a mouse working. 
Still i think it's better than selecting the driver controller
and after that selecting the device controller (if i'm understanding
the current menu ;) BTW, we'll never be able to put a <*> Mouse support
so i think that this is the best way. 


Also, the current menu has some things that i dislike ;)

- Please, don't use names such "i8042 ". Most of the people
  (even people in this list i guess) didn't know what
  a i8042 controller is until they had to configure that ;)
  "Help" is the right place for explainig that i guess ;)

- Replace "mice" by "mouse support" or something. English isn't the only 
  language in the earth. Many people think that the plural
  of "mouse" is "mouses" ;)

- In the current menu, you can disable the i8042 thing and you still can see
 the [*] Keyboard entry alone.
 






and another (crap) suggestion could be to put the pc speaker support under a /proc/something
and remove the menu entry ;)
