Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUDRXwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbUDRXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:52:21 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:49937 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S264212AbUDRXwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:52:19 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: 2.4.26 IRDA BUG - blocker
Date: Mon, 19 Apr 2004 01:52:16 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404190152.16594.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have in my laptop this irda port:
IrCOMM protocol (Dag Brattli)
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0

modules.conf:
alias irda0 nsc-ircc
options nsc-ircc dongle_id=0x08

When I try connect with 2.4.26 kernel to T68i
I getts this message and then port freezes - no devices discovered and no 
communication, sometimes freezes whole laptop:

irlap_adjust_qos_settings(), Detected buggy peer, adjust mtt to 10us!
IrLAP, no activity on link!
IrLAP, no activity on link!
IrLAP, no activity on link!
IrLAP, no activity on link!

previous versions were OK

2.4.26-vanilla
debian woody with bunk2 debs

Thanks a lot

Michal
