Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFCNPS>; Mon, 3 Jun 2002 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316039AbSFCNPR>; Mon, 3 Jun 2002 09:15:17 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:56592 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315943AbSFCNPQ>; Mon, 3 Jun 2002 09:15:16 -0400
Message-ID: <3CFB6C56.2040006@loewe-komp.de>
Date: Mon, 03 Jun 2002 15:17:10 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
In-Reply-To: <Pine.LNX.4.33.0206031403190.24283-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bvermeul@devel.blackstar.nl wrote:
> The KDE panel (kicker) from KDE 3.0 (RedHat 7.3 issue) refuses to start
> up. I get a SIGPIPE in DCOP, and a SIGSEGV in kicker.
> This looks like something changed in regards to permissions, 'cause when I 
> start KDE as root, it does work.
> 

check the permissions of /tmp/{kde|ksocket}-$(LOGNAME)


