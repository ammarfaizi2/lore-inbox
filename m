Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVAUCvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVAUCvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVAUCvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:51:03 -0500
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:61833 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S262243AbVAUCu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:50:59 -0500
From: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
To: "Peter Williams" <pwil3058@bigpond.net.au>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "ckrm-tech" <ckrm-tech@lists.sourceforge.net>
Subject: RE: [ANNOUNCE][RFC] plugsched-2.0 patches ...
Date: Thu, 20 Jan 2005 21:50:48 -0500
Message-ID: <NIBBJLJFDHPDIBEEKKLPMEODDHAA.mef@cs.princeton.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <41F06B26.6000702@bigpond.net.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> I'm hoping that the CKRM folks will send me a patch to add their
> scheduler to plugsched :-)

They are planning to release a patch against 2.6.10.  But their patch wont
stand alone against 2.6.10 and so it might be difficult for you to integrate
their code into a scheduler for plugsched.

Also, the CKRM scheduler only modifies Ingo's O(1) scheduler.  It certainly
would be interesting to have CKRM variants of the other schedulers.  This
points to a whole new level of 'plugsched' in that general O(1) schedulers
need to support fair share plugins.

Marc

