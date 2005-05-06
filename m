Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVEFD13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVEFD13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 23:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVEFD13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 23:27:29 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:18089 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S262208AbVEFD10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 23:27:26 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: ssh and serial console problem
To: govind raj <agovinda04@hotmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 06 May 2005 04:35:12 +0200
References: <40QM8-1IO-35@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DTsgK-0002cd-Sp@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

govind raj <agovinda04@hotmail.com> wrote:

> I have a customized Linux which supports a serial console interface.
> 
> I am able to successfully ssh into this Linux system. If I try to use any of
> the secure (ssh, scp) programs from this ssh session, I am able to
> successfully use them. If I try the same program from the serial console, I
> get a "Login failed: Permission denied" message.

Maybe the login process did not aquire the serial line as it's controling
terminal.

What's the output of tty? How do you login from the serial line?
-- 
"When the pin is pulled, Mr. Grenade is not our friend.
-U.S. Marine Corps

