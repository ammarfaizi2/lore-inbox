Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVITIme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVITIme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVITIme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:42:34 -0400
Received: from odin2.bull.net ([192.90.70.84]:41653 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S964931AbVITIme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:42:34 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: RT bug with 2.6.13-rt4 and 3c905c tornado
Date: Tue, 20 Sep 2005 10:46:17 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201046.17818.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

	This driver works perfectly if you insert the physical card on a PCI slot. If 
you insert this same card on a PCI-X slot, we got the following problem :
When you type "modprobe 3c59x", the system freeze.

Has someone already test this ?

This card works perfectly on the same PCI-X slot with  a non RT kernel.
Do you need some more info ?
