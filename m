Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJTHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJTH3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:29:48 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:16265
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262424AbTJTH2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:28:55 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Wow.  Suspend to disk works for me in test8. :)
Date: Mon, 20 Oct 2003 02:25:11 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310200225.11367.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good grief.  It worked.

echo -n disk > /sys/power/state

No special preparations, no funky scripts, I didn't even have to unload any 
modules or feed strange command line options to grub.  It just... worked.  
(Even the network connection came back up. :)

Congratulations.

Rob

P.S.  (I am breathlessly waiting for my newly resumed system to panic on me, 
but so far... :)
