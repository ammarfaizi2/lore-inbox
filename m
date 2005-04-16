Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVDPSPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVDPSPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVDPSPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 14:15:07 -0400
Received: from mail.charite.de ([160.45.207.131]:8423 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261868AbVDPSPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 14:15:02 -0400
Date: Sat, 16 Apr 2005 20:15:00 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Coredump when program run as root?
Message-ID: <20050416181459.GB6681@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
X-purgate-ID: 149814::050416201508-3543-1A90D726 0
X-purgate-Ad: Checked for SPAM by eleven - eXpurgate www.eXpurgate.net
X-purgate: This mail is considered clean
X-purgate: clean
X-purgate-type: clean
X-purgate-size: 715/651
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this while trying to find out why squid doesn't produce a core
file:

http://lists.samba.org/archive/samba-technical/2002-August/023576.html

Most UNIX variants disable core dumps in programs that have changed their
uid or euid during operation.  This includes Solaris and Linux.

Well, squid does exactly that. How can I still get a coredump? I really
need one. Kernel 2.6.11.7

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
