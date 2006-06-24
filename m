Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWFXQuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWFXQuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWFXQuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:50:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60892 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750886AbWFXQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:50:54 -0400
Subject: Re: 2.6.17-...: looong writeouts
From: Arjan van de Ven <arjan@infradead.org>
To: Donald Parsons <dparsons@brightdsl.net>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1151166629.4409.18.camel@danny.parsons.org>
References: <1151166629.4409.18.camel@danny.parsons.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 18:50:52 +0200
Message-Id: <1151167852.3181.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 12:30 -0400, Donald Parsons wrote:
> I am seeing the same problem.  I had only noticed it
> since I installed Opera-9.0 and thought it was Opera's
> problem.  It even happened when I clicked to read this
> message at www.uwsg.iu.edu/hypermail/linux/kernel/0606.3/0091.html
> to which I am replying.  I had to wait for the disk
> access to end before the message link would display.


Hi,

just a random question to rule things out: can you check if laptop mode
is enabled? (see the /proc/sys/vm/laptop_mode file). Laptop mode will
have the effect of grouping writes together, so if that got enabled
accidentally for some reason, that could explain the behavior you are
seeing. (and it would narrow down the "what broke" search problem to
something that is a lot easier to work on)

Greetings,
   Arjan van de Ven

