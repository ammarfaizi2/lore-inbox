Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRINF6s>; Fri, 14 Sep 2001 01:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273306AbRINF6i>; Fri, 14 Sep 2001 01:58:38 -0400
Received: from tiku.hut.fi ([130.233.228.86]:12806 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S273305AbRINF61>;
	Fri, 14 Sep 2001 01:58:27 -0400
Date: Fri, 14 Sep 2001 08:58:47 +0300 (EET DST)
From: =?ISO-8859-1?Q?Janne_P=E4nk=E4l=E4?= <epankala@cc.hut.fi>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon problems fixed tweaking BIOS memory settings
In-Reply-To: <Pine.SOL.3.96.1010914012859.21012B-100000@virgo.cus.cam.ac.uk>
Message-ID: <Pine.OSF.4.10.10109140850460.21200-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> above 256MiB which meant it couldn't be the chips at fault (failing tests
> were 5 and 8 in memtest86 supplied with SuSE 7.2). 

I have Tyan S1590S (super 7) motherboard and I had this problem with
memtest too.

It was after I changed 768M of memory to it. (I had AT power supply)

when I ran memtest it went fine until it cme to test 5 after that at
random point errors started to flow in (and didn't stop).

Later it was found out that this was due to the fact that the motherboard
converted the 5V from AT PSU to 3.3v needed by dimm trough a tyristor (or
like) and when it was running with a lot of memory and AT supply it heated
up like hell.

when I changed it to ATX supply and changed one dip on the mobo the
tyristor was as cool as ever and memtest ran trough just fine.

not sure if this is the problem with some of you know. The fact that it is
especially test 5 (32-bit moves?) makes me wonder.

Althou all athlon mobos are ATX to begin with *shrug*.

-- 
Janne  justtrowinghisspooninthesouptomakethisevenmoreconfusing.
echo peufiuhu@tt.lac.nk | tr acefhiklnptu utpnlkihfeca

