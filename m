Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263998AbRFJPGw>; Sun, 10 Jun 2001 11:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbRFJPGm>; Sun, 10 Jun 2001 11:06:42 -0400
Received: from i1738.vwr.wanadoo.nl ([194.134.214.209]:16000 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S263998AbRFJPGd>; Sun, 10 Jun 2001 11:06:33 -0400
Date: Sun, 10 Jun 2001 16:21:14 +0200
From: Remi Turk <remi@a2zis.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010610162114.A940@localhost.localdomain>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the problem changed a little bit with ac11. (I didn't try ac10)
apm --standby now actually goes to standby, but doesn't come back
anymore. (Well, it does not completely go down - the light
of my my brandnew USB-mouse does not go off.)
Mikael's patch makes it work, but my power/standby-button
still hardlocks. (same as with ac9)

-- 
Linux 2.4.6-pre2 #1 Sun Jun 10 14:47:38 CEST 2001
