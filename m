Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWBJMia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWBJMia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWBJMia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:38:30 -0500
Received: from mail.charite.de ([160.45.207.131]:63170 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932067AbWBJMi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:38:29 -0500
Date: Fri, 10 Feb 2006 13:38:18 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc2-git8: ieee80211 does not compile
Message-ID: <20060210123817.GQ6668@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get:
  ...
  LD [M]  sound/pci/ac97/snd-ac97-codec.o
  CC [M]  net/ieee80211/ieee80211_module.o
  CC [M]  net/ieee80211/ieee80211_tx.o
net/ieee80211/ieee80211_tx.c: In function ieee80211_xmit':
net/ieee80211/ieee80211_tx.c:473: error: too few arguments to function
make[3]: *** [net/ieee80211/ieee80211_tx.o] Error 1
make[2]: *** [net/ieee80211] Error 2
make[1]: *** [net] Error 2
make[1]: Leaving directory /usr/src/linux-2.6.16-rc2-git8'
make: *** [debian/stamp-build-kernel] Error 2

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
