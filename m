Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWFRDwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWFRDwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 23:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFRDwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 23:52:11 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:10501 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751076AbWFRDwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 23:52:11 -0400
From: "Matt LaPlante" <laplam@rpi.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.17: Contradictory text in KConfig for LSF?
Date: Sat, 17 Jun 2006 23:51:20 -0400
Message-ID: <000001c6928a$75fe2590$fd01a8c0@frostbyte>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaSimywCYas3Du+QT+Yz5E7m26Ggg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Spam-Processed: mail.cyberdogtech.com, Sat, 17 Jun 2006 23:51:29 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Sat, 17 Jun 2006 23:51:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cheers on another great new release!

I'm a bit confused about the new KConfig text for LSF.  From make oldconfig:

"Say Y here if you want to be able to handle very large files (bigger
than 2TB), otherwise say N.

If unsure, say Y.

Support for Large Single Files (LSF) [N/y/?]"

We've got Say Y here if [condition unlikely in standard environments],
otherwise say N.  Then on the next line it says if unsure, say Y.  Then we
have the default in make oldconfig set to N!  So we say to enable in a
certain (rare?) situation, otherwise disable, however if you don't
understand the text above enable, or accept the default to disable.  I feel
like I'm running in circles...

Long story short, shouldn't it be if unsure, say N?  Or otherwise default to
Y?

-
Matt LaPlante



