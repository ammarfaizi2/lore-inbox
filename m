Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSGGUbb>; Sun, 7 Jul 2002 16:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSGGUba>; Sun, 7 Jul 2002 16:31:30 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:57501 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316548AbSGGUb3>;
	Sun, 7 Jul 2002 16:31:29 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207072031.AAA17252@sex.inr.ac.ru>
Subject: Re: [PATCH] simplify networking fcntl
To: willy@debian.org (Matthew Wilcox)
Date: Mon, 8 Jul 2002 00:31:52 +0400 (MSD)
Cc: willy@debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020707195554.O27706@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Jul 7, 2 07:55:54 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> indeed -- did you read the patch?  i simplified sock_no_fcntl so it
> _only_ handled F_SETOWN, which is the only time it's called.

Pardon, I interpreted it wrongly, decided you removed the call down,
which would be right thing to do, only taking care of SIGURG.
SIGIO is not a problem, this handled by generic code.

Andi reminded about patch by James Morris doing something with this.

Alexey
