Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbSLKREF>; Wed, 11 Dec 2002 12:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbSLKREF>; Wed, 11 Dec 2002 12:04:05 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:64699 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267221AbSLKREE>; Wed, 11 Dec 2002 12:04:04 -0500
Message-Id: <4.3.2.7.2.20021211175950.00aebf00@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 11 Dec 2002 18:12:09 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: RE: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  >                intel_830mp_setup },
 > Surely this is wrong or ?
 > Should be "intel_845_setup", I think.

Well, I don't know. With the 830mp_setup, I get
  (WW) RADEON(0): Bad V_BIOS checksum
in the X log (hard) and a few other sporadic effects that I cannot nail down.
With the intel_845_setup, everything appears to be OK.
Board is a D845PESVL with Radeon 7500.
As the D845G have onboard VGA and the PE not, I would suspect
that maybe a different init sequence is necessary.

Margit 

