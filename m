Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269477AbRGaV2D>; Tue, 31 Jul 2001 17:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269474AbRGaV1x>; Tue, 31 Jul 2001 17:27:53 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:13582 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269475AbRGaV1j>; Tue, 31 Jul 2001 17:27:39 -0400
Date: Tue, 31 Jul 2001 23:27:46 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731232746.B13258@emma1.emma.line.org>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20010731025700.G28253@emma1.emma.line.org> <20010730183500.A437@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010730183500.A437@thune.mrc-home.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Mike Castle wrote:

> On Tue, Jul 31, 2001 at 02:57:00AM +0200, Matthias Andree wrote:
> > So, please tell my why Single Unix Specification v2 specifies EIO for
> > rename. Asynchronous I/O cannot possibly trigger immediate EIO.
> 
> It also specifies EIO as possible for write().
> 
> Are you saying that, since SUS2 specifies that write() is capable of
> returning EIO, and asynchronous I/O cannot possibly trigger immediate EIO, 
> that all calls to write() should by synchronous?

No, I'm wondering about the semantics. Of course, write() can be
synchronous (O_SYNC or fs mounted sync e. g.).
