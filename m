Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSBYR2t>; Mon, 25 Feb 2002 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293298AbSBYR2b>; Mon, 25 Feb 2002 12:28:31 -0500
Received: from ns.muni.cz ([147.251.4.33]:19151 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S293219AbSBYR2W>;
	Mon, 25 Feb 2002 12:28:22 -0500
Date: Mon, 25 Feb 2002 15:57:18 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Kristian <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Equal cost multipath crash
Message-ID: <20020225145718.GV18777@informatics.muni.cz>
In-Reply-To: <20020225083911.GA18777@informatics.muni.cz> <20020225155459.38cc7fb9.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225155459.38cc7fb9.kristian.peters@korseby.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian wrote:
: Jan Kasprzak <kas@informatics.muni.cz> wrote:
: > 
: > 	I had a strange failure of my Linux router yesterday. It is quite
: > uncommon setup, but I wonder what could have caused this. The router
: > started to dump the following messages into the syslog, and it stopped
: > routing so our network was not reachable from the outside world:
: > 
: > Feb 24 21:26:49 router kernel: impossible 888
: > Feb 24 21:39:20 router kernel: ible 888
: > Feb 24 21:39:20 router kernel: impossible 888
: > Feb 24 21:39:20 router last message repeated 42 times
: > Feb 24 21:39:20 router kernel: impossible 888
: > Feb 24 21:39:21 router kernel: NET: 344 messages suppressed.
: > Feb 24 21:39:21 router kernel: dst cache overflow
: > Feb 24 21:39:21 router kernel: impossible 888
: > Feb 24 21:39:21 router last message repeated 275 times
: > [... and so on ...]
: 
: Have you applied those grsecurity patches ? I'm getting the same messages with it from time to time when hosts forget to log off. But most of them are harmless and only useful for debugging your firewall-rules.
: 

	No. What are the grsecurity patches? This is stock 2.4.17 kernel.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|\    As anyone can tell you trying to force things on Linux developers   /|
|\\   generally works out pretty badly.              (Alan Cox in lkml)  //|
