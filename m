Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVB0C4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVB0C4d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVB0C4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:56:33 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:35246 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261335AbVB0C4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:56:31 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: userspace app needing signal on parport input change
To: Melkor Ainur <melkorainur@yahoo.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 27 Feb 2005 03:57:39 +0100
References: <fa.l796vn9.1kjep0r@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D5Eco-0001JH-DF@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Melkor Ainur <melkorainur@yahoo.com> wrote:

> Is there a way for a user space app to get a signal or
> maybe woken up from select/read when there is a change
> on a particular input pin on the parallel port?

The easiest hack I can think of is: Change the db9-driver to be freely
configurable and make yourself a zero-axis 13-button "joystick".

http://www.infonewsindia.com/pinout/ibmlpt.txt might help for the pin
assignment. I guess you don't need it, but maybe some other vicolunteer does.

