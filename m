Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSH0QiN>; Tue, 27 Aug 2002 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSH0QiN>; Tue, 27 Aug 2002 12:38:13 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:54713 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316519AbSH0QiL>; Tue, 27 Aug 2002 12:38:11 -0400
Date: Tue, 27 Aug 2002 10:42:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block device/VM question
In-Reply-To: <200208271632.g7RGWsm29662@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0208271038240.3234-101000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-2029314205-1030466546=:3234"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-2029314205-1030466546=:3234
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> > Why so rough?
> 
> Rough? You mean "approximate"? I was working from my vague mamory of
> what I read in the code on the train this morning.

No, rough. I meant, why not use sys_open()?

> My manpage for open(2) claims no such thing. It doesn't mention
> O_DIRECT. Maybe your libc6 is newer.

Certainly not, as I'm not using libc6. But my manpages are newer, the 
latest version is appended. It might clear this issue to you.

> Oh, well, thanks.I suppose you won't give me a recipe saying "do this
> and your device won't be cached", but I'll follow the lead.

I can't, because I don't have your code here and can't tell your needs. I 
just try to serve it all. (I mean it all depends not just on where you go, 
but also on what you have.)

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

---1463811839-2029314205-1030466546=:3234
Content-Type: APPLICATION/octet-stream; name="open.2.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208271042260.3234@hawkeye.luckynet.adm>
Content-Description: 
Content-Disposition: attachment; filename="open.2.bz2"

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
MLmNgXalmP6/ij/4u5IpwoSEwFXVgA==
---1463811839-2029314205-1030466546=:3234--
