Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSJLRQH>; Sat, 12 Oct 2002 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJLRQH>; Sat, 12 Oct 2002 13:16:07 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:4859 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S261296AbSJLRQG>; Sat, 12 Oct 2002 13:16:06 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Alan Chandler <alan@chandlerfamily.org.uk>,
       Michael.Abshoff@mathematik.uni-dortmund.de
Subject: Re: How does ide-scsi get loaded?
Date: Sat, 12 Oct 2002 18:22:17 +0100
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st> <3DA8342C.40408@mathematik.uni-dortmund.de> <200210121555.19492.alan@chandlerfamily.org.uk>
In-Reply-To: <200210121555.19492.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210121822.18018.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  >
>   >append = "enableapic hdd=ide-scsi"
>
> so isn't /etc/lilo.conf in /etc.
>
> I keep saying - the string ide-scsi is not used anywhere in /etc
>
> [and believe me, I have also looked manually at all these sorts of places]

try appending 'hdd=ide-cd' then ide-scsi won't be enabled for that device.

Nick

