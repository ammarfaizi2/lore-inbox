Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUIPMXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUIPMXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUIPMWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:22:44 -0400
Received: from relay.felk.cvut.cz ([147.32.80.7]:64775 "EHLO
	relay.felk.cvut.cz") by vger.kernel.org with ESMTP id S268035AbUIPMUw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:20:52 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: CD-ROM can't be ejected
Date: Thu, 16 Sep 2004 14:20:00 +0200
User-Agent: KMail/1.6.2
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200409160025.35961.cijoml@volny.cz>
            <20040916102236.GB2300@suse.de>
            <200409161444.30998.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409161444.30998.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-ID: <200409161420.00784.cijoml@volny.cz>
X-MailScanner-felk: Found to be clean
X-MailScanner-SpamCheck-felk: not spam, SpamAssassin (score=-4.9, required 5,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne èt 16. záøí 2004 13:44 Denis Vlasenko napsal(a):
> > > > > 2.4.27-mh1
> > > > > notas:~# /home/cijoml/eject
> > > > > ATAPI device hdc:
> > > > >   Error: Not ready -- (Sense key=0x02)
> > > > >   (reserved error code) -- (asc=0x53, ascq=0x02)
> > > > >   The failed "Start/Stop Unit" packet command was:
> > > > >   "1b 00 00 00 02 00 00 00 00 00 00 00 "
> > > > > command failed - sense 2/53/2
> > > >
> > > > Your tray is still locked, are you sure it isn't mounted?
> > >
> > > Yes I am. This is written into console and I am logged only into this
> > > console and I copied whole commands from login to eject... :(
> >
> > For the third time, don't trim the cc list! group reply please.
> >
> > Something else must be keeping your drive locked. What else do you have
> > running in the system? It's enough if one app is just holding the drive
> > open, the drive wont get unlocked on umount then.
>
> Michal, you can use 'lsof -nP' to check for that
> --
> vda

Thanks fuser helped too...

M.
