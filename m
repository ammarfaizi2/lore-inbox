Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCLF6b>; Mon, 12 Mar 2001 00:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRCLF6V>; Mon, 12 Mar 2001 00:58:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56581 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129524AbRCLF6F>; Mon, 12 Mar 2001 00:58:05 -0500
Message-ID: <3AAC70B0.DE7FF89@evision-ventures.com>
Date: Mon, 12 Mar 2001 07:46:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: XingFei <xing.fei@fujixerox.co.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux localization
In-Reply-To: <E14cHxf-000178-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > My work will concern with the internationalization of Linux
> > So, could anybody tell me what kinds of features should be in the
> > consideration when linux be localized from english to Japanese or chinese,
> > say using 2 bytes character set.
> 
> Most of the Linux userspace libraries are set up for handling UTF8 and
> other internationalisations. Fonts are more of an issue and lack of application
> translations. Filenames are defined to be UTF8.

Something along the lines of pcvt (*BSD)
for full userspace line discipline handling on
the console would be great. Read: much saner then trying to do this all
in kernel like
linux does currently. Maybe the linux way was justified during the days
of 386sx 16MHz
somehow. Currently it's relly just plain ugly. Try using some other
character set then iso8859-1 on the linux console to see why.
