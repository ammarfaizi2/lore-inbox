Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbRGCN6s>; Tue, 3 Jul 2001 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264423AbRGCN62>; Tue, 3 Jul 2001 09:58:28 -0400
Received: from jalon.able.es ([212.97.163.2]:17331 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264407AbRGCN6T>;
	Tue, 3 Jul 2001 09:58:19 -0400
Date: Tue, 3 Jul 2001 15:58:01 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Erik Meusel <erik@wh58-709.st.uni-magdeburg.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: include/asm-i386/checksum.h
Message-ID: <20010703155801.A1206@werewolf.able.es>
In-Reply-To: <2487.994146067@kao2.melbourne.sgi.com> <Pine.LNX.4.33.0107031356200.16796-200000@wh58-709.st.uni-magdeburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0107031356200.16796-200000@wh58-709.st.uni-magdeburg.de>; from erik@wh58-709.st.uni-magdeburg.de on Tue, Jul 03, 2001 at 13:58:58 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010703 Erik Meusel wrote:
>On Tue, 3 Jul 2001, Keith Owens wrote:
>
>> >P.S.: would it be possible to patch the menuconfig in that way, that it
>> >does look in the whole include-path for the <ncurses.h> and relating
>> >files? they aren't in /usr/include/ in my system and I'm tired of patching
>> >linux/scripts/lxdialog/Makefile all the time. :)
>> Where is it on your system?  What patch do you apply?
>It is in /usr/local/include/ since I installed it myself, months ago.
>The patch is attached. Just made silly to use /usr/local/ instead of /usr/.
>

make a couple symlinks and you will not have to touch kernel makefiles:
ln -s /usr/local/include/ncurses /usr/include


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac23 #1 SMP Tue Jul 3 01:58:06 CEST 2001 i686
