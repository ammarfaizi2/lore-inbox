Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTA3Voh>; Thu, 30 Jan 2003 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbTA3Voh>; Thu, 30 Jan 2003 16:44:37 -0500
Received: from daimi.au.dk ([130.225.16.1]:30926 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267643AbTA3Vog>;
	Thu, 30 Jan 2003 16:44:36 -0500
Message-ID: <3E399EEE.407D5B6@daimi.au.dk>
Date: Thu, 30 Jan 2003 22:53:50 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugo Mills <hugo-lkml@carfax.org.uk>
CC: sundara raman <sundararamand@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: doubts in INIT - while system booting up
References: <20030126170034.30209.qmail@web20507.mail.yahoo.com> <20030126172837.GA1196@carfax.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mills wrote:
> 
> On Sun, Jan 26, 2003 at 09:00:34AM -0800, sundara raman wrote:
> 
> > 8) while system booting up, it shows the following
> > error
> >
> >        INIT: Id "x" respawing too fast: disabled for 5
> > minutes
> 
>    It's not a kernel problem -- there's something broken in your X
> Windows configuration. xdm (or kdm or gdm) keeps trying to start and
> fails, and init is restarting it, and it fails...

I have recently had the same problem when I forgot to include some
driver in the kernel which was required by my X configuration.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
