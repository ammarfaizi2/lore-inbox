Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWGAOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWGAOEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGAOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:04:04 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1945 "EHLO
	asav10.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750740AbWGAOED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:04:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAHwcpkSBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: keyboard raw mode
Date: Sat, 1 Jul 2006 10:04:00 -0400
User-Agent: KMail/1.9.3
Cc: Congjun Yang <congjuny@yahoo.com>, linux-kernel@vger.kernel.org
References: <20060701050023.31696.qmail@web32009.mail.mud.yahoo.com> <20060701095541.GO26883@lug-owl.de>
In-Reply-To: <20060701095541.GO26883@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607011004.01317.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 July 2006 05:55, Jan-Benedict Glaw wrote:
>   * All protocol drivers (eg. the atkbd driver) will *never* ever
>     stuff the raw I/O anywhere.

Actually some of them do via EV_MSC/MSC_RAW events. So raw code should be
available through evdev nodes and also on x86 keyboard driver in raw mode
should also pass raw data through (from atkbd only).

Congjun, what 2.6.x kernel have you tried?

-- 
Dmitry
