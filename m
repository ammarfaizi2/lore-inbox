Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVJNTdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVJNTdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJNTdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:33:40 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:32980 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750779AbVJNTdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:33:39 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: AIC79xx fails built into kernel, but works as a module
Date: Fri, 14 Oct 2005 14:39:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXOsS4dQenICsIJSniOppNw8xVnIACRI3+Q
In-Reply-To: <EXCHG2003c0D543Tuyl00000f37@EXCHG2003.microtech-ks.com>
Message-ID: <EXCHG2003vl7PDqqgNj00001028@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 14 Oct 2005 19:29:13.0981 (UTC) FILETIME=[8F4EFAD0:01C5D0F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Apparently things where only less troublesome with it loaded as
a module, eventually things still fell over.

Apparently here is the base issue:

The device I am using does not work with the Linux driver, and an
Adaptec 320 controller running at 320, it works with the same
controller running at 160.  It fails under vanilla 2.6.13.3 kernel,
and all other recent ones that we tried.
  
It will work on the same machine with Windows and a Adaptec 320
controller, but only if the windows machine has a new driver.  The
error it gives looks very similar to a cabling issue, and we had
ruled out cabling as we had replaced all combinations of cables,
and tried 2 separate Adaptec cards both of which failed, and tried
different devices.

I works fine with a LSILogic 320 and the associated mpt driver.

I believe the OEM is going to be either fixing their device (if
it is their fault) , or informing Adaptec about the issue if they
believe it is an Adaptec driver issue.

                   Roger

