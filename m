Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317379AbSFRKex>; Tue, 18 Jun 2002 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSFRKex>; Tue, 18 Jun 2002 06:34:53 -0400
Received: from cambot.suite224.net ([209.176.64.2]:12 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S317379AbSFRKew>;
	Tue, 18 Jun 2002 06:34:52 -0400
Message-ID: <000b01c216b4$4c3596e0$eff583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Frank Davis" <fdavis@si.rr.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206180044410.3577-100000@obiwan>
Subject: Re: 2.5.22 : fs/intermezzo/presto.c compile error
Date: Tue, 18 Jun 2002 06:38:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have gotten this same error since about 2.5.12... I have not tried
anything earlier as yet.

Matthew
----- Original Message -----
From: "Frank Davis" <fdavis@si.rr.com>
To: <linux-kernel@vger.kernel.org>
Cc: <fdavis@si.rr.com>
Sent: Tuesday, June 18, 2002 12:49 AM
Subject: 2.5.22 : fs/intermezzo/presto.c compile error


> Hello all,
>   While 'make bzImage', I received the following error
>
> presto.c: In function `presto_get_permit':
> presto.c:625: structure has no member named `p_pptr'
> presto.c: In function `presto_put_permit':
> presto.c:682: structure has no member named `p_pptr'
> presto.c: In function `presto_is_read_only':
> presto.c:1136: structure has no member named `p_pptr'
> presto.c:1139: structure has no member named `p_pptr'
> presto.c:1132: warning: `mask' might be used uninitialized in this
function
> make[2]: *** [presto.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
> make[1]: *** [intermezzo] Error 2
> make[1]: Leaving directory `/usr/src/linux/fs'
> make: *** [fs] Error 2
>
> I think that presto_c2m(presto_cache *cache) (looked at dir.c) needs to be
> used, but I attempted that, and it didn't seem to work.
>
> Regards,
> Frank
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

