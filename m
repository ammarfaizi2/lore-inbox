Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSEUTLd>; Tue, 21 May 2002 15:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315452AbSEUTLc>; Tue, 21 May 2002 15:11:32 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:2956 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315451AbSEUTLb>;
	Tue, 21 May 2002 15:11:31 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200205211910.XAA06681@sex.inr.ac.ru>
Subject: Re: [PATCH] Tasklet cleanup
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 21 May 2002 23:10:22 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <E17A4GO-0003uj-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 21, 2 05:40:55 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, not sure why you exported tasklet_vec & tasklet_hi_vec?

Maybe, they were used in some inlines, when the exports were added.
Maybe, it was a mud. If they can be static... amen.

Alexey
