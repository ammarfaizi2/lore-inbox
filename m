Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933059AbWKMVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWKMVRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKMVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:17:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61366 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933059AbWKMVRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:17:09 -0500
Date: Mon, 13 Nov 2006 22:17:07 +0100
From: Petr Baudis <pasky@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Krufky <mkrufky@linuxtv.org>,
       =?iso-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>,
       linux-dvb@linuxtv.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged  into v4l-dvb tree
Message-ID: <20061113211707.GE18879@pasky.or.cz>
References: <200611131711.46626.j.suarez.agapito@gmail.com> <45589E2E.7070304@linuxtv.org> <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 05:44:16PM CET, Linus Torvalds wrote:
> Looking at the patch, one obvious bug stands out: the new case statement 
> for SAA7134_BOARD_AVERMEDIA_777 doesn't have a "break" at the end.

Oh, sorry about that. :-( I was splitting the patch to multiple ones and
merging it with Jose Alberto's, and apparently this got lost somewhere
in the process...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
