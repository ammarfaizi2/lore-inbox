Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSBAAKh>; Thu, 31 Jan 2002 19:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291445AbSBAAK1>; Thu, 31 Jan 2002 19:10:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:65039 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291444AbSBAAKQ>; Thu, 31 Jan 2002 19:10:16 -0500
Message-ID: <3C59DCC4.EA3848E@linux-m68k.org>
Date: Fri, 01 Feb 2002 01:09:40 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10201311542370.5906-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

James Simmons wrote:

> > > +   scancode = scancode >> 1;       /* lowest bit is release bit */
> > > +   down = scancode & 1;
> >
> > Shouldn't that be the other way 'round?
> 
> I don't know. Anyone?

He's correct, the up/down event is received in the lsb bit, the other 7
bits are the keycode.

bye, Roman
