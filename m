Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTDQPbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTDQPbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:31:09 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261649AbTDQPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:31:08 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171545.h3HFjPoH000129@81-2-122-30.bradfords.org.uk>
Subject: Re: Help with virus/hackers
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 17 Apr 2003 16:45:25 +0100 (BST)
Cc: root@chaos.analogic.com, jbriggs@briggsmedia.com (joe briggs),
       linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <1050588754.31390.72.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 17, 2003 03:12:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Iau, 2003-04-17 at 14:55, Richard B. Johnson wrote:
> > (2) Boot with init=/bin/bash
> 
> Doesnt help you
> > (5)  Examine /etc/inetd.conf (if one exists). If you see an
> >      unusual entry near the end, you have been 'rooted'. Newer
> >      systems use xinetd and won't get invaded this way.
> Wrong. Old xinetd < 2.3.10 has remote root exploits and real
> ones circulate
> > (6)  Check /etc/passwd for a strange account.
> Rootkits patch other stuff
> > (7)  Check /bin/login for a new file-date.
> > (8)  Check /usr/sbin/sendmail for a new file-date.
> >      Check /usr/sbin/inetd      ""
> >      Check /usr/sbin/xinetd     ""
> >      Check /usr/sbin/syslogd    ""
> >      Check /usr/sbin/klogd      ""
> >      Check /usr/sbin/in.*       ""
> 
> Rootkits know about avoiding this
> 
> > If none of these have recent writes, just change the password on
> > the root account and be happy. You just has some file-system
> > corruption and you can fix up /etc/DIR_COLORS (for your color-ls
> > problem) and fix /etc/profile or /root/.bashrc, /root/.profile
> > to fix the bad environment variables created by these scripts.
> 
> Never do this. You don't know what else has changed on the system. You
> should always (barring odd exceptions) do a full reinstall. Also clean
> user executable files if neccessary (roots .login is often archived and
> people rerun exploits from it...)

Also, note that any data stored on that machine is potentially
compromised, such as passwords for other boxes, etc.  You should
really also change all of those.  If the box was a firewall, the
rulesets also become known, etc.

I've often wondered whether it would be worth connecting a very large
serial EEPROM to a serial port interface, and have it effectively
appear as a solid state printer, (to that you could cheaply log to an
unmodifyable device).  Has anybody ever tried this?

John.
