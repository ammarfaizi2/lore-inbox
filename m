Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUIPLrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUIPLrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIPLqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:46:50 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23309 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268003AbUIPLoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:44:55 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jens Axboe <axboe@suse.de>, "Bc. Michal Semler" <cijoml@volny.cz>
Subject: Re: CD-ROM can't be ejected
Date: Thu, 16 Sep 2004 14:44:30 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409160025.35961.cijoml@volny.cz> <200409161113.55719.cijoml@volny.cz> <20040916102236.GB2300@suse.de>
In-Reply-To: <20040916102236.GB2300@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161444.30998.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 2.4.27-mh1
> > > > notas:~# /home/cijoml/eject
> > > > ATAPI device hdc:
> > > >   Error: Not ready -- (Sense key=0x02)
> > > >   (reserved error code) -- (asc=0x53, ascq=0x02)
> > > >   The failed "Start/Stop Unit" packet command was:
> > > >   "1b 00 00 00 02 00 00 00 00 00 00 00 "
> > > > command failed - sense 2/53/2
> > >
> > > Your tray is still locked, are you sure it isn't mounted?
> >
> > Yes I am. This is written into console and I am logged only into this
> > console and I copied whole commands from login to eject... :(
>
> For the third time, don't trim the cc list! group reply please.
>
> Something else must be keeping your drive locked. What else do you have
> running in the system? It's enough if one app is just holding the drive
> open, the drive wont get unlocked on umount then.

Michal, you can use 'lsof -nP' to check for that
--
vda

