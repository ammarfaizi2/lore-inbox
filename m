Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJ0LVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 06:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTJ0LVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 06:21:24 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:32181 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261595AbTJ0LVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 06:21:23 -0500
Date: Mon, 27 Oct 2003 12:21:14 +0100
From: Ookhoi <ookhoi@humilis.net>
To: wsy@merl.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile-time error in 2.6.0-test9
Message-ID: <20031027112114.GA25221@favonius>
Reply-To: ookhoi@humilis.net
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost> <200310261635.h9QGZTe13121@localhost.localdomain> <20031026171650.GD23792@localhost> <200310262319.h9QNJDr13814@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310262319.h9QNJDr13814@localhost.localdomain>
X-Uptime: 09:15:37 up 2 days,  2:34, 20 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wsy@merl.com wrote (ao):
> Now, to figure out why I've got a bunch of unresolved symbols in when
> I do "make modules_install".

As others said, you need module-init-tools

> I am beginning to suspect that there's a particular bit of sequence
> that I'm not doing quite right.  
> 
> It's:
> 
> 	make  

You only need to do a 'make' (after the 'make *config') ...

> 	make bzImage
> 	make install
> 	make modules

> 	make modules_install

... and a 'make modules_install' with a 2.6 kernel.

I thought this was in the README, but it seems not (anymore?).

Btw, 2.6 rocks. Thanks all.
