Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTDVWis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDVWis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:38:48 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:56820 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S263879AbTDVWir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:38:47 -0400
Date: Tue, 22 Apr 2003 18:47:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.68 IDE Oops at boot [working now]
To: "digitale@digitaleric.net" <digitale@digitaleric.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221850_MC3-1-3587-B664@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This fixes it, thank you very much!  I am currently running 2.5.68 with your 
> IDE patch.  One annoyance is that the order of IDE channels is different 
> between 2.4.20 and 2.5.68 - the Silicon Image SATA controller is detected 
> first on 2.5 but not on 2.4.  I've just put a simple script to swap 
> /etc/fstab at boot based on the running kernel, but the device swap is not 
> very user-friendly.  Other than that, I've got no complaints - the system is 
> running quite well!


  Try 2.5.68-ce2, which I just posted to the list.

  It has the bus order fix and has Manfred's patch as well, though I
couldn't test his fix on my setup.

------
 Chuck
