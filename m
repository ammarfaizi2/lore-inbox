Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVDOQWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVDOQWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVDOQWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:22:40 -0400
Received: from web51404.mail.yahoo.com ([206.190.38.183]:62568 "HELO
	web51404.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261858AbVDOQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:22:37 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=VXT/drtQa0WwncF2EI7+KwJ3tjMy1NlKOgzfnZvSbaCL656WMQaaTGIsN7ueeEVOcOBJPL9Ejr0lQXGsfFTcMdWQLfP8AouT4MryDCt15H7ncr+JwMopvzfplioTcOVozVO5oXOuYBLtatJPsJebmRY7Q5Vi+Cfb5mtwgYZbBWw=  ;
Message-ID: <20050415162236.44964.qmail@web51404.mail.yahoo.com>
Date: Fri, 15 Apr 2005 18:22:36 +0200 (CEST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: [Linux-usb-users] 2.6 PCMCIA/USB question
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel <linux-kernel@vger.kernel.org>,
       linux-usb-user <linux-usb-users@lists.sourceforge.net>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had hoped that one can figure things out from /proc and /sys. SHould'n
there be a way to do this? And no, trial and error is not really an
option. The devices in question are WCDMA/UMTS mobile data cards. They
will differ only by the SIM card inserted by the user. The ICCID of the
SIM is unknown during development and I would like to avoid to many
configuration files.

Regards
  Joerg

--- Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 15 Apr 2005, Joerg Pommnitz wrote:
> 
> > Hello all,
> > I have a question that I could not figure out from other sources. I
> have
> > the following hardware: an integrated CardBus USB host adapter with a
> > connected USB serial device with three interfaces (normally
> > ttyUSB0...ttyUSB2). Now I want to use 3 of these devices (remember:
> they
> > are integrated, so I can't just plug the USB device onto the same host
> > adapter). I know device A is in CardBus slot 1, device B is in CardBus
> > slot 2 and so on. 
> > 
> > Now the question: How do I figure out which ttyUSBx belongs to which
> > device?
> 
> You can look in the system log.  If you want, you can actually control 
> which goes where by creating a udev configuration file.
> 
> Alan Stern
> 
> 


	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
