Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272055AbTGYNEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272056AbTGYNEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:04:07 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:22168 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272055AbTGYNC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:02:59 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01BDE949@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: why the current kernel config menu layout is a mess
Date: Fri, 25 Jul 2003 15:18:08 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from my poking around in the whole Kconfig structure, it seems that the
menu structure is tied awfully closely to the underlying directory
structure.  this would make it overly difficult to shift parts of
the config menu around without dragging the corresponding directories
around as well.
<Sources are located regarding programming hierarchy _but_
<relevant Kconfig can tune situation using 'depends' feature
<at ease so that menuconfig, kernelserver ... have an optimized view
<over kernel tree.OTOH a major problem resides in lack of functionnalities
<especially when you don't know where to look at (ie.alphabetical order,
<search engine....I'm adding those functions to kernelServer (wconf) ASAP.
