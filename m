Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275094AbRJFIcY>; Sat, 6 Oct 2001 04:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275096AbRJFIcO>; Sat, 6 Oct 2001 04:32:14 -0400
Received: from net.spam.ee ([194.204.44.99]:65526 "HELO volk.internalnet")
	by vger.kernel.org with SMTP id <S275094AbRJFIb6> convert rfc822-to-8bit;
	Sat, 6 Oct 2001 04:31:58 -0400
Subject: Re: [POT] Which journalised filesystem ?
From: Tonu Samuel <tonu@please.do.not.remove.this.spam.ee>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9plgfn$6kq$2@ncc1701.cistron.net>
In-Reply-To: <m1669uyuqy.fsf@frodo.biederman.org>
	<E15pbX5-0007do-00@calista.inka.de>  <9plgfn$6kq$2@ncc1701.cistron.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13 (Preview Release)
Date: 06 Oct 2001 10:32:30 +0200
Message-Id: <1002357150.3083.20.camel@volk.internalnet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 01:41, Miquel van Smoorenburg wrote:
> >Does that mean we can or we can't? Is there a flush write cache operation in
> >ATA? I asume there is one in SCSI?
> 
> Well hdparm has a -W option with which you can turn on/off the
> write cache. If that works (and it appears it does) you should be
> able to turn write cache off, write *one* block so that the
> cache gets flushed and turn it back on. I'm not sure how to
> test this, though.

Doesn't hdparm -W0f do the work?

  Tõnu

