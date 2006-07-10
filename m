Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWGJGZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWGJGZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbWGJGZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:25:54 -0400
Received: from mail.gmx.de ([213.165.64.21]:47566 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161343AbWGJGZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:25:52 -0400
Cc: vendor-sec@lst.de, linux-kernel@vger.kernel.org, mtk-manpages@gmx.net,
       akpm@osdl.org
Content-Type: text/plain; charset="utf-8"
Date: Mon, 10 Jul 2006 08:25:51 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <20060709175744.GZ4188@suse.de>
Message-ID: <20060710062551.307040@gmx.net>
MIME-Version: 1.0
References: <20060707070703.165520@gmx.net>
 <20060707040749.97f8c1fc.akpm@osdl.org>
 <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de>
 <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de>
 <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil>
 <20060709175744.GZ4188@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>, lcapitulino@mandriva.com.br
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Should we use the first patch for it? It does work too.
> 
> No, I'll rebase the patch for 2.6.17.x - basically you just need to
> change the two mutex_lock_nested() to mutex_lock() and that is it. But
> first I'd like Michael to retest as well (and more importantly, I'll do
> some testing myself too).

Jens,

Could you post a 2.6.17 patch please.

Cheers,

Michael
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
