Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVBNKbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVBNKbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVBNKbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:31:08 -0500
Received: from nina-2.cs.keele.ac.uk ([160.5.89.35]:45798 "EHLO
	nina.cs.keele.ac.uk") by vger.kernel.org with ESMTP id S261386AbVBNKbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:31:00 -0500
Subject: Re: aacraid fails under kernel 2.6
To: mark_salyzyn@adaptec.com (Salyzyn, Mark)
Date: Mon, 14 Feb 2005 10:30:45 +0000 (GMT)
Cc: jonathan@cs.keele.ac.uk (Jonathan Knight), markh@osdl.org (Mark Haverkamp),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <60807403EABEB443939A5A7AA8A7458BC57CD7@otce2k01.adaptec.com> from "Salyzyn, Mark" at Feb 11, 2005 11:41:29 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1D0dV7-0003rQ-00@nina.cs.keele.ac.uk>
From: Jonathan Knight <jonathan@cs.keele.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then turn off both read and write cache on the card ...


We've tried with no cache and we had multiple failures over the weekend.
We are running 2.4.20 on some of these boxes and it is stable.  We're
only having problems with the 2.6 kernel.

These systems did stay running for a few hours and then started dying every
few minutes and then stable again for a few hours.  They are in a air
conditioned machine room with UPS power supplies and we have 11 identical
2500 systems.  Only the ones running 2.6 have issues and those issues start
the moment 2.6 is installed so we're convinced its software.

What's puzzling me is that the aacraid driver isn't so different between
2.4.20 and 2.6.  Is there a debugging run or something that I can get that
would help diagnose the problem?



-- 
  ______    jonathan@cs.keele.ac.uk    Jonathan Knight,
    /                                  Department of Computer Science
   / _   __ Telephone: +44 1782 583437 University of Keele, Keele,
(_/ (_) / / Fax      : +44 1782 713082 Staffordshire.  ST5 5BG.  U.K.
