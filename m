Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTJURf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTJURf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:35:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:55228 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263205AbTJURfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:35:19 -0400
Date: Tue, 21 Oct 2003 19:35:18 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.44.0310211828021.32738-100000@phoenix.infradead.org>
Subject: Re: [PATCH][2.6-mm] radeonfb as module
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <23586.1066757718@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > acquire_console_sem is exported, 
> > but release_console_sem is not
> > 
> > this seems like a bug for me,
> > as if one acquire console_sem, he should be able to relase it
> 
> 
> True that release_console_sem should be exported as well. But that lock 
> shouldn't be in a driver. In fbcon.c yes but not the driver. My next pacth
> 
> will fix that.
> 
Hi James,
i've some related questions :-)

are you going to merge new radeonfb driver in fbdev bk tree ?
is the driver in ppc bk tree newer? (i have such impression)


svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

