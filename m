Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBYO4C>; Mon, 25 Feb 2002 09:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSBYOzx>; Mon, 25 Feb 2002 09:55:53 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:2094 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S287817AbSBYOzl>; Mon, 25 Feb 2002 09:55:41 -0500
Date: Mon, 25 Feb 2002 15:54:59 +0100
From: Kristian <kristian.peters@korseby.net>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Equal cost multipath crash
Message-Id: <20020225155459.38cc7fb9.kristian.peters@korseby.net>
In-Reply-To: <20020225083911.GA18777@informatics.muni.cz>
In-Reply-To: <20020225083911.GA18777@informatics.muni.cz>
X-Mailer: Sylpheed version 0.7.2claws2 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> wrote:
> 
> 	I had a strange failure of my Linux router yesterday. It is quite
> uncommon setup, but I wonder what could have caused this. The router
> started to dump the following messages into the syslog, and it stopped
> routing so our network was not reachable from the outside world:
> 
> Feb 24 21:26:49 router kernel: impossible 888
> Feb 24 21:39:20 router kernel: ible 888
> Feb 24 21:39:20 router kernel: impossible 888
> Feb 24 21:39:20 router last message repeated 42 times
> Feb 24 21:39:20 router kernel: impossible 888
> Feb 24 21:39:21 router kernel: NET: 344 messages suppressed.
> Feb 24 21:39:21 router kernel: dst cache overflow
> Feb 24 21:39:21 router kernel: impossible 888
> Feb 24 21:39:21 router last message repeated 275 times
> [... and so on ...]

Have you applied those grsecurity patches ? I'm getting the same messages with it from time to time when hosts forget to log off. But most of them are harmless and only useful for debugging your firewall-rules.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :..........................:
