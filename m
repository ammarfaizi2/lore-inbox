Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbUAJAbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUAJAbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:31:18 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:24265 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S264415AbUAJAbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:31:14 -0500
X-AmikaGuardian-Id: mail6.speakeasy.net10736946732617742
X-AmikaGuardian-Category: AN:Override Structure : 1.6
X-AmikaGuardian-Category: AN:Vectored : 1.6
X-AmikaGuardian-Category: AN:Forwarded Mail : 1.6
X-AmikaGuardian-Category: AN:Override : 1.6
X-AmikaGuardian-Category: AN:Exception : 1.6
X-AmikaGuardian-Action: Do Nothing()
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Aaron Burt <aaron@speakeasy.org>
Newsgroups: local.linux-kernel
Subject: Re: ALSA: bad sound with low CPU load
Date: Sat, 10 Jan 2004 00:31:13 +0000 (UTC)
Organization: The Aluminum Bavariati
Message-ID: <slrnbvuhuh.8lo.aaron@aluminum.bavariati.org>
References: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org> <3FFF39F7.1060205@gmx.de>
NNTP-Posting-Host: aluminum.bavariati.org
X-Trace: aluminum.bavariati.org 1073694673 11207 127.0.0.1 (10 Jan 2004 00:31:13 GMT)
X-Complaints-To: news
NNTP-Posting-Date: Sat, 10 Jan 2004 00:31:13 +0000 (UTC)
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
> Aaron Burt wrote:
>> Basically, sound comes out as a hissing, garbled mess *unless* I load
>> down the CPU.  A kernel compile seems to do nicely for this purpose.
>
> Is CPU Disconnect on? Turn if off and maybe it is OK then. (It was like 
> this in Windows with Via KT133 Chipset.)
>
> Try using athcool.

You got it in one!  "athcool off" fixes the sound, "athcool on" breaks
it again.  

Updating my rcfiles,
  Aaron
