Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280266AbRKBPoA>; Fri, 2 Nov 2001 10:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280288AbRKBPnu>; Fri, 2 Nov 2001 10:43:50 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:16269 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S280266AbRKBPng>;
	Fri, 2 Nov 2001 10:43:36 -0500
Date: Fri, 2 Nov 2001 16:42:49 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Notes accordig to yenta.c and frozing kernel
Message-ID: <20011102164249.A609@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have three scenarios:

The first one:
Boot linux to multi-user: when initialize PCMCIA, then kernel
freeze

The second one:
Boot linux to single-user and then run /etc/init.d/pcmcia start
(I have Debian sid distribution): kernel freeze

The third one:
Boot linux to the multi-user, but w/o initializing PCMCIA. When
computer booted, go to single user using 'init 1'. Then try to
initialize PCMCIA: PCMCIA works!!!??? Now I can switch to
multi-user and everythink works fine...

Is there a method to test where is the problem?

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
