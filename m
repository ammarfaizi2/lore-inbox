Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTHLOWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTHLOWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:22:04 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:54757 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270370AbTHLOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:22:01 -0400
Subject: Re: 2.6.0-test3 cannot mount root fs
From: Christophe Saout <christophe@saout.de>
To: herbert@13thfloor.at
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20030812140609.GB1926@www.13thfloor.at>
References: <E19mZ6L-000Jrv-00.arvidjaar-mail-ru@f22.mail.ru>
	 <20030812140609.GB1926@www.13thfloor.at>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1060698116.4346.0.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 12 Aug 2003 16:21:56 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, 2003-08-12 um 16.06 schrieb Herbert Pötzl:

> please provide the file and line number, where
> linux-2.6.0-test3 contains the string "cannot mount rootfs".
> (or where this string is synthesized)
> I am not able to locate it ...

I think he means:

init/do_mounts.c - line 278

panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

