Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJZKXT>; Sat, 26 Oct 2002 06:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJZKXS>; Sat, 26 Oct 2002 06:23:18 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:20236 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262038AbSJZKXR>; Sat, 26 Oct 2002 06:23:17 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Sun, 20 Oct 2002 16:14:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bosko Radivojevic <bole@etf.bg.ac.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Security Protection System
Message-ID: <20021020141444.GA6280@elf.ucw.cz>
References: <Pine.LNX.4.44.0210161018370.19750-100000@alumno.inacap.cl> <Pine.LNX.4.44.0210161607590.28724-100000@falcon.etf.bg.ac.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210161607590.28724-100000@falcon.etf.bg.ac.yu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Filesystem Access Domain subsystem allows restriction of accessible
> filesystem parts for both individual users and programs. Now you can
> restrict user activities to only its home, mailbox etc. Filesystem Access
> Domains works on device, dir and individual file granularity.
> 
> IP Labeling lists enable restriction on allowed network connections on per
> program basis. From now on, you may configure your policy so that no one
> except your favorite MTA can connect to remote port 25

How do you handle ptrace()? Per-program security seems -- quite
strange to me. Either you completely disallow ptrace(), or I can not
seee how per-program security can be usefull...
									Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
