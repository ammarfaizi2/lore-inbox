Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULBItR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULBItR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULBItR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:49:17 -0500
Received: from mail1.upco.es ([130.206.70.227]:14746 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261566AbULBItE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:49:04 -0500
Date: Thu, 2 Dec 2004 09:49:00 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Input/ACPI layer glitches switching from 2.6.7 to 2.6.9?
Message-ID: <20041202084900.GA16740@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

   I have a couple of little problems switching from 2.6.7 to 2.6.9 with
   respect to the input layer. I have a Sony Vaio FX701 which worked like a
   charm on 2.6.7. Having an ALPS touchpad, both kernel where patched with
   the corresponding patch from Peter Österlund (available at
   http://web.telia.com/~u89404340/touchpad/index.html ). 

   The first "problem" is maybe related to this. Switching from 2.6.7 to
   2.6.9, enumeration of devices by EVDEV input module changed (touchpad was
   event0 in 2.6.7, changed to event1 in 2.6.9) which make necessary a
   switch of X config... 

   The second is more important. Someway, the detection by the acpid daemon
   of "Fn+F12" (suspend to disk key) has turned flaky. I mean, I need to try
   several times before the system recognize the key: I have to press it
   in a specific sequence (first Fn down, than F12 down, than Fn up, then
   F12 up) and yet only sometimes it is recognized. 

   I understand there is not much data here; but before spamming the list
   with hundreds of unuseful logs, I would like to have some hint about
   which kind of data is needed. 

   Thank you very much, have a nice day,

                                        Romano    

      


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
