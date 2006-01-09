Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWAIQmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWAIQmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWAIQmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:42:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45070 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751259AbWAIQme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:42:34 -0500
Date: Mon, 9 Jan 2006 17:42:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109164214.GA10367@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hch.

Any specific reason why xfs uses a indirection for the Makefile?
It is planned to drop export of VERSION, PATCHLEVEL etc. from
main makefile and it is OK except for xfs due to the funny
Makefile indirection.

I suggest:
git mv fs/xfs/Makefile-linux-2.6 fs/xfs/Makefile

OK?

	Sam
