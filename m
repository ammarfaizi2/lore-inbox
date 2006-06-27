Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWF0O1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWF0O1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWF0O13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:27:29 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:36271 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932476AbWF0O13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:27:29 -0400
Date: Tue, 27 Jun 2006 16:27:33 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: broken auto-repeat on PS/2 keyboard
Message-ID: <20060627162733.551f844f@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with current git kernel keyboard repeat for my plain PS/2 keyboard
stopped working.

Reverting
	0ae051a19092d36112b5ba60ff8b5df7a5d5d23b

fixes the problem...

-- 
	Paolo Ornati
	Linux 2.6.17-gd2581eb4 on x86_64
