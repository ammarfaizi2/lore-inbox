Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSENMwn>; Tue, 14 May 2002 08:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315693AbSENMwm>; Tue, 14 May 2002 08:52:42 -0400
Received: from mail.medav.de ([213.95.12.190]:61455 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S315690AbSENMwm> convert rfc822-to-8bit;
	Tue, 14 May 2002 08:52:42 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Neil Conway" <nconway.list@ukaea.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 14 May 2002 14:52:29 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <3CE0D952.7080403@evision-ventures.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-Id: <20020514114455.D4CE26FC1@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 11:30:58 +0200, Martin Dalecki wrote:

>There is no problem to go in paralell on different channels for
>requests. The serialization has only to be done
>for the drive setup.

This assumption is *not* valid in all cases!

For example, get dtips10.pdf from the CMD website and learn how the
CMD646 may fail on concurrent requests on both channels.

There are other chips which need runtime serialization.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


