Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbUBWXns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUBWXns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:43:48 -0500
Received: from smtp3.att.ne.jp ([165.76.15.139]:946 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262094AbUBWXnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:43:46 -0500
Message-ID: <02a201c3fa66$d4ee2190$34ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
References: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60> <20040222204541.GA26793@mail.shareable.org> <008d01c3f99c$9033e3c0$34ee4ca5@DIAMONDLX60> <20040223115822.GA28909@mail.shareable.org>
Subject: Re: UTF-8 filenames
Date: Tue, 24 Feb 2004 08:42:47 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> > > Do you have a list or description of the specific stty options that
> > > are used?
> >
> > [...] I'll try to remember to look next weekend.
>
> Thanks; that would be useful.

Actually not.  I had a few minutes to look yesterday at a Red Hat 7.3 system
at work, and it seems that Linux stty had none of the necessary options.  In
keyboard input with an IME active, the backspace key deleted a single byte
instead of an entire character, exactly one of the problems that commercial
Unix (and MS-DOS) systems solved 20 years ago.

The reason I think my checking was not useful is that I think you already
knew that Linux didn't have it  :-)

Sorry I cannot check details on which bits are used by commercial Unix
systems.  As mentioned previously, I no longer have access to any such
systems.  Some vendors documented the options in the "man stty" pages in
both Japanese and English, but other vendors only documented them in the
"man stty" page in Japanese.

