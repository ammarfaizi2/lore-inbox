Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTJYHsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 03:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJYHsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 03:48:00 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24475
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262538AbTJYHr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 03:47:59 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Kconfig choice menu help text is not working in -test8
Date: Sat, 25 Oct 2003 02:44:56 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310250244.56881.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm banging away on the bzip patch, adding a choice menu to kconfig for 
bzip/gzip/uncompressed, and I notice that the help text isn't working right.

To see this bug in action, go to "processor type and features", and descend 
into the "subarchitecture menu" at the top of it.  Pull up the help text on 
anything, it'll say there's no help available.

Now look at arch/i386/Kconfig, and note that there IS help text for all those 
menu choices.  It's just not displaying it...

Rob
