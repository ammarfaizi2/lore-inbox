Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965324AbVKBWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbVKBWiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbVKBWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:38:20 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:63204 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S965324AbVKBWiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:38:19 -0500
Date: Thu, 3 Nov 2005 00:38:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: I2C regression in post 2.6.14 gits..
Message-ID: <20051102223818.GE3423@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically,  BTTV driver fails to control internal
I2C devices in Hauppauge WinTV card with Bt848 onboard.

Baseline 2.6.14 works fine,  but 2.6.14-git2 fails.

Comparing kernel messages in between respective running
kernel versions with respect to bttv driver messages
I don't see really obvious differences at all.
Nevertheless it fails to activate correct input.

There are apparently also some changes in video
input driver, but nothing that plainly shows to
be related with this particular issue. (bttv / bt84x)

Any ideas ?  Possible fixes ?

  /Matti Aarnio
