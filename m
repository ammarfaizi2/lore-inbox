Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755315AbWKMSXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbWKMSXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbWKMSXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:23:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:23484 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1755315AbWKMSXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:23:44 -0500
X-Sasl-enc: G8riewU2DwaekEF4A6BUbpYcXE70cnxGe3BI4yq6cUZp 1163442223
Date: Mon, 13 Nov 2006 16:23:34 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-ID: <20061113182334.GC17406@khazad-dum.debian.net>
References: <1163280972.32084.13.camel@localhost.localdomain> <20061113190635.597ab587.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113190635.597ab587.khali@linux-fr.org>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Jean Delvare wrote:
> This raises the question of what these drivers (ams, hdaps...) really
> are, and where they really belong. The hdaps driver is very different
> from all other driver in the hwmon directory. Maybe they would be
> better located in drivers/input/accel? This is an open question, I
> really don't know.

I'd vote for the accelerometer class (whatever that thing is! please cc
hdaps-devel with such stuff) and all accelerometer drives being in
drivers/input/accel, yes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
