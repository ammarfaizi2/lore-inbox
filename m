Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSLQXAw>; Tue, 17 Dec 2002 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLQXAw>; Tue, 17 Dec 2002 18:00:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:62152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266114AbSLQXAv>;
	Tue, 17 Dec 2002 18:00:51 -0500
Date: Tue, 17 Dec 2002 15:03:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: eric lin <fsshl@centurytel.net>
cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
In-Reply-To: <3E001D07.5010006@centurytel.net>
Message-ID: <Pine.LNX.4.33L2.0212171502210.17648-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| > Yes!!! I have a patch for fixing this issue.
| >
| > You can import this changeset into BK by piping this whole message to:
| > '| bk receive [path to repository]' or apply the patch as usual.
| >
| > ===================================================================
| >
| >
| > ChangeSet@1.868, 2002-12-10 12:07:45-08:00, jsimmons@kozmo.(none)
| >   The VT tty layer depends on the input api now. Fixed this dependency.
| >
| >
| >  Kconfig |    1 +
| >  1 files changed, 1 insertion(+)
| >
| >
| > diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
| > --- a/drivers/char/Kconfig	Tue Dec 10 12:16:48 2002
| > +++ b/drivers/char/Kconfig	Tue Dec 10 12:16:48 2002
| > @@ -6,6 +6,7 @@
| >
| >  config VT
| >  	bool "Virtual terminal"
| > +	depends on INPUT=y
| >  	---help---
| >  	  If you say Y here, you will get support for terminal devices with
| >  	  display and keyboard devices. These are called "virtual" because you
| >
| > ===================================================================
| >
| >
| > This BitKeeper patch contains the following changesets:
| I copied this piece as patch1.tar.gz

This piece is just the above piece in gz format.
You don't need this latter piece, just the above part.

| --------------------------------------------------------------
| > +
| > ## Wrapped with gzip_uu ##
| >
| >
| > begin 664 bkpatch6044
| > M'XL(`+!+]CT``]54VVH;,1!]MKYB("\MQ;NZ[,T+6]RFEX24UKA.7TH?A';L
| > MW=@KF97L9,-^?&6[N1!,H*5]J"X(9H;#F3D'G<"EQ38?7-FZ:8RVY`3.C'7Y
| > M8&EN&Q.\T$;C2Q^<&N.#X<:VH6U5N*KUYF98Z_7&$9^=2*<JV&)K\P$+Q'W$
| > M=6O,!]/W'R\_O9D24A1P6DF]P*_HH"B(,^U6KDH[EJY:&1VX5FK;H).!,DU_
| > M7]IS2KG?,4L%C9.>)31*>\5*QF3$L*0\RI*(W+4P?DS]"0KCC+)1%,6C7B24
| > M"?(.6)`E&5`>,G\H,)[3-(_B(<UR2N$H*+QB,*3D+?S=!DZ)@EF%\&T&SG6P
| > MDAVV4.(:=6G!:'`^MQ\YR'4-VEP'\*&^P=(G:ONK$+7J`B`7(.(TC<CD8>!D
| > M^)N+$"HI>0VW]7J-J_%!\B;)EH%I%]_O6O_1EVV]4SY4E6S#"V7TO%X<ADT%
| > MI9'@/.LYIUG6BU0D*.99R>>E$!R/3_<90`_IWY1Y]40<97M'':O>F>O?T2:E
| > MW.+56)D2/?DE=COD8+-\!I)Q?^/$JR[8B!]L)YZ:CHW^>]/M5?D"P_9Z?[R)
| > L)D<%^@,SGF?`R.`1L_//D\M9T3W\/ZI"M;2;IE!2\7B$2'X"W[RZ@MX$````
| > `
| > end
| >
| -------------------------------------------------------------------
| then in my /linux-2.5.52/
|
| fsshl@www:~/linux-2.5.52$ gzip -cd patch1.tar.gz | patch -p1
| patch: **** Only garbage was found in the patch input.

Yep.

| Please help

-- 
~Randy

