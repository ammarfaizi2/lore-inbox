Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262801AbREOPsw>; Tue, 15 May 2001 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbREOPsm>; Tue, 15 May 2001 11:48:42 -0400
Received: from g126.dialup.pcsystems.de ([212.63.44.126]:38648 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262801AbREOPs1>;
	Tue, 15 May 2001 11:48:27 -0400
Message-ID: <3B014FA5.D0BF4111@pcsystems.de>
Date: Tue, 15 May 2001 17:47:49 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mirabilos <eccesys@topmail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Device Numbers, LILO
In-Reply-To: <20010515121635.B5C402F84AC@www.topmail.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mirabilos wrote:

> >That's not the issue.  LILO takes whatever you pass to root= and converts
> >it to a device number at /sbin/lilo time.  An idiotic practice on the
> >part of LILO, in my opinion, that ought to have been fixed a long time
> >ago.
>
> That's why you have to use append="root=blah" for devfs :)

I don't really think you have to. With 'lba32'
enabled (maybe also without that ... ) and just using lilo
normally it works with devfs.


Nico

ps: lilo.conf:

boot=/dev/discs/disc0/disc
lba32
...
image = /boot/244nospeak
  root = /dev/root
  label = nospeak
  append = "LOC=HOME"



flapp:~/bootdisk # lilo -V
LILO version 21.6



