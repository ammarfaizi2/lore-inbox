Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUGNC4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUGNC4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUGNC4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 22:56:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44457 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267304AbUGNC4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 22:56:02 -0400
Subject: Bizarre audio behavior
From: Lee Revell <rlrevell@joe-job.com>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: paul@linuxaudiosystems.com, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089773762.2729.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 22:56:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is absolutely bizarre.  If I run JACK from a GNOME terminal,
even with a large period size, all I get are these error messages:

load = 0.1875 max usecs: 5.000, spare = 1328.000
delay of 2996.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 2665.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 45411.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 32071.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 34742.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 3217.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 3077.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 45437.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 10693.000 usecs exceeds estimated spare time of 1328.000; restart ...
delay of 5342.000 usecs exceeds estimated spare time of 1328.000; restart ...
load = 0.9565 max usecs: 23.000, spare = 1310.000
delay of 5342.000 usecs exceeds estimated spare time of 1310.000; restart ...
delay of 53432.000 usecs exceeds estimated spare time of 1310.000; restart ...

etc.

If I run if from an xterm or a text console, it works perfectly, even 
with a really small buffer:

load = 0.9302 max usecs: 5.000, spare = 661.000
load = 0.8405 max usecs: 5.000, spare = 661.000
load = 1.7716 max usecs: 18.000, spare = 648.000
load = 2.1621 max usecs: 17.000, spare = 649.000
load = 2.8828 max usecs: 24.000, spare = 642.000
load = 1.8168 max usecs: 5.000, spare = 661.000
load = 1.2838 max usecs: 5.000, spare = 661.000
load = 1.7680 max usecs: 15.000, spare = 651.000
load = 1.2594 max usecs: 5.000, spare = 661.000
load = 1.0051 max usecs: 5.000, spare = 661.000

etc.

I have no idea where this bug could be, it seems like it would have to be 
display-related.

Lee 

