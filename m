Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTGKS53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTGKS4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:56:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25988
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264825AbTGKSHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:07:06 -0400
Date: Fri, 11 Jul 2003 19:20:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111820.h6BIKssN017422@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: -- END AUDIO BLOK --
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This leaves me holding

a97_plugin_wm97xx	-	waiting final device assignment
hal2			-	For SGI. Not sure if its needed
				as there is good ALSA support
harmony			-	For PARISC. Same comment as hal2

and the config fixes which depend on the hal2/harmony decision. What
would the maintainers prefer - merge them or rely on the ALSA ones ?

It also leaves cs4281 differently broken to before. That needs a lot
more work but I'm digging into it currently
