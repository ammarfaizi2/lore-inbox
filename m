Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312400AbSC3HVW>; Sat, 30 Mar 2002 02:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312401AbSC3HVM>; Sat, 30 Mar 2002 02:21:12 -0500
Received: from mx20a.rmci.net ([205.162.184.37]:57484 "HELO mx20a.rmci.net")
	by vger.kernel.org with SMTP id <S312400AbSC3HVD>;
	Sat, 30 Mar 2002 02:21:03 -0500
Subject: config problems with pcmcia and parport
From: Kristis Makris <devcore@freeuk.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Mar 2002 00:20:59 -0700
Message-Id: <1017472862.566.82.camel@mcmicro>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

`make xconfig` spits out this error message after I'm done configuring
2.5.7:

++++++++++++++++++++++++++++++++++++++++++
ERROR - Attempting to write value for unconfigured variable
(CONFIG_PARPORT_PC_PCMCIA)
++++++++++++++++++++++++++++++++++++++++++

Here's part of my .config file. Note that CONFIG_PARPORT_PC_PCMCIA is
nowhere to be found in .config, not even commented out. The "Parallel
port support" configuration screen displays the entry "Support for
PCMCIA management for PC-style ports" twice, and the first of the two
entries is tri-state, but not greyed out. None of the three options can
be selected though. The second one is greyed out.

CONFIG_PCMCIA=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y

Anybody else seeing this problem?


