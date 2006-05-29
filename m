Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWE2VHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWE2VHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWE2VHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:07:30 -0400
Received: from nonada.if.usp.br ([143.107.131.169]:46016 "EHLO
	nonada.if.usp.br") by vger.kernel.org with ESMTP id S1751298AbWE2VH3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:07:29 -0400
From: =?iso-8859-1?q?Jo=E3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
To: linux-kernel@vger.kernel.org
Subject: /sys/class/net/eth?/carrier and uevents
Date: Mon, 29 May 2006 18:07:42 -0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605291807.42725.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I would like to have my network interfaces configured when plugged on the 
network cable. I know there are some daemons that do this for me (laptop-net, 
ifplugd, whereami), but it would be nice if a simple udev rule take care of 
this to me. However, as I can see with kernel 2.6.16 and udevmonitor (udev 
version 0.091), nonetheless /sys/class/net/eth?/carrier changes when I plug 
the network cable, no uevent is generated. Could this be changed so udev get 
triggered when network cables get plugged? As I am no kernel developper, this 
is only a suggestion, hoping that it would be a simple and pertinent job for 
those ho know the subject.

Thanks in advance,

João.
