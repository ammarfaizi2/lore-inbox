Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTJ2Q7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTJ2Q7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 11:59:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:13999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261659AbTJ2Q7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 11:59:06 -0500
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2003 17:59:24 +0100
MIME-Version: 1.0
Subject: Re: oops in skb in 2.4.20/2.4.22-ac4/2.4.23pre1 but not 2.6.0-test1/test7
Message-ID: <3F9FFFFC.12003.4B9DC3A@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everything works now. skbuff.c seems to be ok.

At the end it seems to be an issue between one of my three memory 
modules and the installed Promise ide controller. Without the Promise 
controller everythink works and with a changed memory stick also 
everything works. I did a lot of memtests but no error was shown. I 
think one of the memory modules has some electrical specialties when 
used together with the Promise controller.

Thanks a lot to everybody who tried to shed some light on this.

--
Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

