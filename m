Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSD1MtD>; Sun, 28 Apr 2002 08:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSD1MtC>; Sun, 28 Apr 2002 08:49:02 -0400
Received: from khms.westfalen.de ([62.153.201.243]:46814 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S310224AbSD1MtC>; Sun, 28 Apr 2002 08:49:02 -0400
Date: 28 Apr 2002 11:18:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8NjsfDgXw-B@khms.westfalen.de>
In-Reply-To: <3CC9D865.80104@antefacto.com>
Subject: Re: [PATCH] 2.5.10 IDE 42
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

padraig@antefacto.com (Padraig Brady)  wrote on 26.04.02 in <3CC9D865.80104@antefacto.com>:

> Martin Dalecki wrote:
>  > Uz.ytkownik Sebastian Droege napisa?:
>  >
>  >> On Fri, 26 Apr 2002 09:41:30 +0200
>  >> Martin Dalecki <dalecki@evision-ventures.com> wrote:
>  >>
>  >> Hi,
>  >>
>  >> @@ -584,27 +585,25 @@
>  >>              drive->failures = 0;
>  >>          } else {
>  >>              drive->failures++;
>  >> +            char *msg = "";
>  >>
>  >> My compiler won't compile that ;)
>  >> Declare msg after the function's beginning and it compiles fine
>  >
>  >
>  > Well it doesn't has to be the function it sufficient to be
>  > the beginng of a block. However this is puzzling me,
>  > becouse the gcc-3.1 snap eats the above just like if it
>  > where a C++ complier!!!

> Note the "mixed declarations and code" @
> http://www.gnu.org/software/gcc/gcc-3.0/c99status.html

And see the -std= option for selecting what ou want it to conform to.

MfG Kai
