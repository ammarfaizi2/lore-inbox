Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSEONg2>; Wed, 15 May 2002 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSEONg1>; Wed, 15 May 2002 09:36:27 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:11861 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S314395AbSEONg0>; Wed, 15 May 2002 09:36:26 -0400
Message-ID: <3CE263FF.FC17E7C0@ukaea.org.uk>
Date: Wed, 15 May 2002 14:34:55 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177yXY-0001t9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The problem is that with the busy flag on we are wasting quite
> > a significant amount of CPU time spinning around it for no good...
> 
> Why spin on the busy flag. Instead you just let the person who clears
> the flag check the pending work and do it.

Isn't that what happens?  Since when are we spinning on busy?  Certainly
not in vanilla 2.5.14, unless I'm much mistaken.

Martin - I haven't read your last couple of patches yet but did you
really change it this drastically?

Neil
