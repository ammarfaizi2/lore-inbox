Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRGKPPp>; Wed, 11 Jul 2001 11:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbRGKPPf>; Wed, 11 Jul 2001 11:15:35 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:44000 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S266715AbRGKPPY>;
	Wed, 11 Jul 2001 11:15:24 -0400
Message-ID: <003001c10a1c$d7563e00$fe00000a@cslater>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B4C21DA.5FFCBE2@uni-mb.si>
Subject: Re: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 11:19:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a problem at all, because UNIX does not guarantee that
> a process will get at least one CPU slice every X seconds.
> ( read : UNIX is not a real time system )

It is not a problem when a system is isolated from all other systems, but if
we do this while some program is in a tcp/ip session, like a webserver, the
program will not beable to respond to an outside computer for the time while
we are swaping and initilizing kernels.  The tcp connection will time out on
the side of the other computer then. But this is still quite managable
compared to a minute or 2 for a system to totaly reboot itself.

> soft-suspend "freezes" processes for several hours anyway ...

Yes, so it will not be a problem at least with processes dieing because they
did not get message X at time Y.



