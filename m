Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbTDBT1J>; Wed, 2 Apr 2003 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263154AbTDBT1J>; Wed, 2 Apr 2003 14:27:09 -0500
Received: from smtp03.web.de ([217.72.192.158]:49432 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S263152AbTDBT1I>;
	Wed, 2 Apr 2003 14:27:08 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Philippe Troin <phil@fifi.org>
Subject: Re: subsystem crashes reboot system?
Date: Wed, 2 Apr 2003 21:32:41 +0200
User-Agent: KMail/1.5
References: <200304021806.h32I6M709795@mako.theneteffect.com> <200304022044.27530.freesoftwaredeveloper@web.de> <87k7ecg1kz.fsf@ceramic.fifi.org>
In-Reply-To: <87k7ecg1kz.fsf@ceramic.fifi.org>
Cc: Mitch Adair <mitch@theneteffect.com>,
       rmiller@duskglow.com (Russell Miller), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304022132.41821.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 April 2003 21:07, you wrote:

> > hm, I don't think, that watchdog will catch this, because the
> > userspace-watchdog daemon will still be running properly in a crash
> > case (or did I understand something wrong?)
>
> Unless you configure it to stat your filesystems, like in:
>
>   watchdog-device         = /dev/misc/watchdog
>   realtime                = yes
>   priority                = 99
>   admin                   =
>   file                    = /
>   file                    = /var
>   file                    = /usr
>   ...

Yes that's true. I didn't remember this option.
With this, watchdog would be a solution of russel's problem,
without writing some kernel-error-handling for it.

Regards Michael Buesch.

-- 
-------------
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

