Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbUKPTe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUKPTe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbUKPTdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:33:52 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:38120 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262097AbUKPTcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:32:53 -0500
To: jengelh@linux01.gwdg.de
CC: miklos@szeredi.hu, greg@kroah.com,
       rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr> (message from
	Jan Engelhardt on Tue, 16 Nov 2004 20:24:49 +0100 (MET))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
 <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
 <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr>
Message-Id: <E1CU94I-0007YH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 20:32:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 15? But include/linux/miscdevice.h lists more than 20 static numbers for
> possibly-going-to-be-loaded-modules!

Yes, minors 0-139 are static ones, and 140-254 are dynamic ones.
Those 20 are all in the static range.

Miklos
