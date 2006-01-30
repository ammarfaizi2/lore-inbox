Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWA3QQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWA3QQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWA3QQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:16:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47237 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932360AbWA3QQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:16:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 17:15:20 +0100
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, hch@infradead.org, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DE3B98.nail16ZM1LULL@burner>
References: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr>
 <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org>
 <20060130122349.GA13871@infradead.org>
In-Reply-To: <20060130122349.GA13871@infradead.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 30, 2006 at 01:04:08PM +0100, Matthias Andree wrote:
> > Why is it a *kernel* task to invent SCSI identifier for a non-SCSI
> > transport that does not have such identifiers, in addition to the device
> > name? libscg is already doing it for /dev/hd* and /dev/pg*.
> > How about USB or Firewire or SATA? Do they have ID or LUN?
>
> Nothing but SPI (parallel scsi) has a target id.  Everything that broadly
> falls under SAM has luns.  Because SPI is dying transport the scsi
> midlayer will get rid of having a mandatory target id mid-term.  Relying
> on the target id to have any useful meaning is dangerous, it doesn't
> have a really useful meaning on anything but SPI.

And now please tell me how you believe this will be inplemented.....

Every kernel implementation I am aware of uses device instance numbers
and BTW: I am open for any non-dogmatic discussion.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
