Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTJPJES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTJPJES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 05:04:18 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:15784 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262755AbTJPJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 05:04:17 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01F6EE59@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: About _real_ free memory
Date: Thu, 16 Oct 2003 11:04:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a process tries to allocate and use more than the really free
amount, some cache will be dropped automatically.  From a performance
point of view, this could of course be undesirable, but normally
there's no need to think about it.

<Why don't we have a command to drop some cache ? or maybe some
<kernel rules to do it ? we could gain some more scalability doing that kind
of
<stuff during low load.Another problem is end-user point of view :

<	-What's available on a box before swapping ?
<	-Do I have to add RAM right now ?

