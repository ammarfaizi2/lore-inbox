Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSHaUgl>; Sat, 31 Aug 2002 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHaUgl>; Sat, 31 Aug 2002 16:36:41 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:11509
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317950AbSHaUgk>; Sat, 31 Aug 2002 16:36:40 -0400
Subject: Re: [patch 2.4.19] reboot on out-of-file handles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020831201638.GG721@gallifrey>
References: <20020831201638.GG721@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 21:41:08 +0100
Message-Id: <1030826468.3582.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 21:16, Dr. David Alan Gilbert wrote:
> Hi,
>   Please find below a patch that adds the ability to panic if you run
> out of file handles (by setting /proc/sys/fs/file-max-panic to none-0).

You can already do this reliably in user space as part of your watchdog
daemon processing.


