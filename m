Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277269AbRJDX2u>; Thu, 4 Oct 2001 19:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277265AbRJDX23>; Thu, 4 Oct 2001 19:28:29 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:21167 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277203AbRJDX2T>;
	Thu, 4 Oct 2001 19:28:19 -0400
Date: Fri, 05 Oct 2001 00:28:44 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@alex.org.uk
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Simon Kirby <sim@netnation.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <309943687.1002241724@[195.224.237.69]>
In-Reply-To: <E15pGhY-0004Qz-00@the-village.bc.nu>
In-Reply-To: <E15pGhY-0004Qz-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 04 October, 2001 11:10 PM +0100 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> You only think that. After a few minutes the kiddie pulls down your
> routing because your route daemons execute no code. Also during the
> attack your sshd wont run so you cant log in to find out what is up

There is truth in this. Which is why doing things like
a crude WRED on the card, in the firmware,
(i.e. before it sends the data into user space) is something
we looked at but never got round to.

--
Alex Bligh
