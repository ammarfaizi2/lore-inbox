Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSGOUxA>; Mon, 15 Jul 2002 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSGOUw6>; Mon, 15 Jul 2002 16:52:58 -0400
Received: from ulima.unil.ch ([130.223.144.143]:11649 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S317636AbSGOUw2>;
	Mon, 15 Jul 2002 16:52:28 -0400
Date: Mon, 15 Jul 2002 22:55:23 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Can't compil 2.4.19-rc[34]
Message-ID: <20020715205523.GA16091@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after make dep; make bzImage:

scripts/split-include include/linux/autoconf.h include/config
make -r -f tmp_include_depends all
make[1]: Entering directory `/usr/src/linux-2.4'
make[1]: *** No rule to make target
`/usr/src/linux-2.4/fs/inflate_fs/infblock.h', needed by
`/usr/src/linux-2.4/fs/inflate_fs/infcodes.h'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.4'
make: *** [tmp_include_depends] Error 2
Exit 2

And there is no /usr/src/linux-2.4/fs/inflate_fs/infcodes.h file...

If I should provide other info, please write directly to me: I am not on
the ml...

Thank you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
