Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265485AbTF1XMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTF1XMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:12:45 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:10119 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265472AbTF1XMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:12:33 -0400
Date: Sun, 29 Jun 2003 01:26:42 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: "Luca T." <luca-t@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random broken?
Message-ID: <20030629012641.A23587@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: "Luca T." <luca-t@libero.it>,
	linux-kernel@vger.kernel.org
References: <3EFE2231.2050707@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EFE2231.2050707@libero.it>; from luca-t@libero.it on Sun, Jun 29, 2003 at 01:18:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this a bug?

No, it is not. If there's not enough random data available, reading from
/dev/random will block. Moving the mouse around will generate some interrupts
(or other stuff) that contribute to the entropy...

Rudo.
