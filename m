Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbREHSPj>; Tue, 8 May 2001 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbREHSPa>; Tue, 8 May 2001 14:15:30 -0400
Received: from www.topmail.de ([212.255.16.226]:61832 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S133040AbREHSPZ>;
	Tue, 8 May 2001 14:15:25 -0400
Message-ID: <003a01c0d7ea$d9969f20$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Keith Owens" <kaos@melbourne.sgi.com>, <kdb@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <23270.989323782@ocs3.ocs-net>
Subject: Re: kdb wishlist
Date: Tue, 8 May 2001 18:15:13 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
>   used by emacs, bash, minicom etc.

Why not Alt-SysRq-D (like Debug) or so?

> * Command history.  Handle up/down/left/right/delete keys.  Each
>   kdba_io routine is responsible for recognising the arch specific
>   keys, with a common history and editting routine.

yes!

> * Clean up repeating commands.  Pressing enter at the kdb prompt
>   repeats the previous command, no matter what the previous command
>   was.  Some commands it makes no sense to repeat (bp in particular),
>   for other commands you want to repeat the command but without the
>   parameter (md in particular).

Should be configurable. Sometimes I accidentally hit enter or do it
just to do something...

-mirabilos
-- 
EA F0 FF 00 F0 #$@%CARRIER LOST

