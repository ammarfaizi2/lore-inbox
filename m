Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVB1SoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVB1SoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVB1SoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:44:17 -0500
Received: from mail.gondor.com ([212.117.64.182]:33033 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S261494AbVB1SoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:44:14 -0500
Date: Mon, 28 Feb 2005 19:44:14 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: key bounce problem with 2.6.11-rc5
Message-ID: <20050228184414.GA31929@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since I upgraded my ASUS M2400N laptop from 2.6.10 to 2.6.11-rc5, I got
an annoying key bounce problem. I'm not sure if it's purely a kernel
problem, because it seems to occur only in xwindows, but booting back to
2.6.10 made the bouncing disappear, and 2.6.11-rc5 seems to contain
some changes to the keyboard driver.

It looks like the sequence of events is the following:

Usually, when I press a key, the char shows up on the screen
immediately. But sometimes, the char does not show up until I press a
second key, and in that moment, the first char shows up twice, together
with the second one. (But I may be wrong with that observation, because
the sequence of events is really fast - it's more like an impression
than a real observation)

What can I do to help debugging that problem? Are there certain -rc
versions between 2.6.10 and 2.6.11-rc5 you want me to try out?

Yours,
Jan


