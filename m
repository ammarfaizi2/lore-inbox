Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285936AbRLHU5a>; Sat, 8 Dec 2001 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285939AbRLHU5V>; Sat, 8 Dec 2001 15:57:21 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:45585 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285936AbRLHU5N> convert rfc822-to-8bit; Sat, 8 Dec 2001 15:57:13 -0500
Date: Fri, 7 Dec 2001 21:37:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: making an ide hd sleep
Message-ID: <20011207213708.B176@elf.ucw.cz>
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by alfik.ms.mff.cuni.cz id VAA17519
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi, I´d like to know if it's possible to put an ide hd to sleep after (for
> example) 15 min. idle (i don´t know if an hd under linux stays  idle that
> amount of time. ). I tried mount -o noatime and hdparm -S 150 /dev/hda, but
> it seems that when it sleeps it starts working after a few seconds (when it
> sleeps!). Is there a way to have this feature under linux?

Get noflushd (see freshmeat). Its more clever than hdparm -S.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
