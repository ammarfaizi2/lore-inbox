Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJXOpd>; Wed, 24 Oct 2001 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275570AbRJXOpY>; Wed, 24 Oct 2001 10:45:24 -0400
Received: from sith.mimuw.edu.pl ([193.0.97.1]:33029 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id <S275265AbRJXOpJ>;
	Wed, 24 Oct 2001 10:45:09 -0400
Date: Wed, 24 Oct 2001 16:45:33 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: acenic breakage in 2.4.13-pre
Message-ID: <20011024164533.C15474@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Jeff Garzik wrote:

> If there are no complaints nor better suggestions, I would prefer to use
> the code in acenic.c / 8139cp.c as a base, since that code has been
> stable for a little while.

Speaking of acenic - it's broken in 2.4.13-pre. I have 3c985 and all I
get with 2.4.13-pre is "Firmware NOT running!". After I backed the
changes from -pre patch it started and works fine. Maybe the problem is
I have it in 32bit PCI slot?

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
