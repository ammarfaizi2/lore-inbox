Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265921AbRF1N5o>; Thu, 28 Jun 2001 09:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265922AbRF1N5e>; Thu, 28 Jun 2001 09:57:34 -0400
Received: from mail.ftr.nl ([212.115.175.146]:758 "EHLO ftrs1.intranet.FTR.NL")
	by vger.kernel.org with ESMTP id <S265921AbRF1N51>;
	Thu, 28 Jun 2001 09:57:27 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F151A@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: John Fremlin <vii@users.sourceforge.net>, Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: A signal fairy tale - a little comphist
Date: Thu, 28 Jun 2001 15:57:23 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>        A signal number cannot be opened more than once concurrently;
>        sigopen() thus provides a way to avoid signal usage clashes
>        in large programs.
YOU> Signals are a pretty dopey API anyway - 

Exactly. When signals were made up, signalhandlers were supposed to
not so much more then a last cry and then exit the application. sigHUP
to re-read the config was not supposed to happen.

YOU> so instead of trying to patch
YOU> them up, why not think of something better for AIO?

Yeah, a select() on excepfds.

