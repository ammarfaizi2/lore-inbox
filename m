Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTEEVKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEEVKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:10:14 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:34184 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S261351AbTEEVKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:10:13 -0400
Date: Mon, 5 May 2003 23:22:34 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: error compiling awe_wave in 2.5.69
Message-ID: <Pine.LNX.4.44.0305052321490.2003-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sound/oss/awe_wave.c: In function `awe_probe_isapnp':
sound/oss/awe_wave.c:4798: warning: implicit declaration of function 
`isapnp_find_dev'
sound/oss/awe_wave.c:4801: warning: assignment makes pointer from integer 
without a cast
sound/oss/awe_wave.c:4802: structure has no member named `prepare'
sound/oss/awe_wave.c:4804: structure has no member named `activate'
sound/oss/awe_wave.c:4806: structure has no member named `deactivate'
sound/oss/awe_wave.c:4807: structure has no member named `deactivate'
sound/oss/awe_wave.c: In function `awe_deactivate_isapnp':
sound/oss/awe_wave.c:4826: structure has no member named `deactivate'
make[4]: *** [sound/oss/awe_wave.o] Error 1
make[3]: *** [sound/oss] Error 2
make[2]: *** [sound] Error 2
make[1]: *** [all] Error 2



Pau

