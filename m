Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270642AbTHQT2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTHQT2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:28:20 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45710 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270642AbTHQT2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:28:18 -0400
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Rychter <jan@rychter.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m2r83kce2h.fsf@tnuctip.rychter.com>
References: <3F38FE5B.1030102@yahoo.com>
	 <1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk>
	 <864r0lwmov.fsf@trasno.mitica>  <m2r83kce2h.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061148472.23525.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 20:27:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 19:51, Jan Rychter wrote:
> Does anybody have the actual CPU revisions corresponding to these
> changes? There has been a lot of confusion over this.

Ezra -> 3dnow, no cmov  (500MHz->1Ghz)
Nemeiah -> sse, cmov (1Ghz-)
Anataur -> dunno yet, I'd assume sse

The chips report cmov only if they have full cmov instructions, so
a look at /proc/cpuinfo will tell you.


