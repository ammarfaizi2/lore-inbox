Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTIPJNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTIPJNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:13:07 -0400
Received: from mail.zmailer.org ([62.240.94.4]:16776 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261806AbTIPJNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:13:05 -0400
Date: Tue, 16 Sep 2003 12:13:03 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: DON'T use DNS BLs,  they appear to be dying fast...
Message-ID: <20030916091303.GU9192@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or rather..   lattest thing to raise its ugly head is
    dorkslayers.com
which in itself, and in all its subdomains ("*.dorkslayers.com")
points to Verisign's web service.    (Properly functioning lookup
routines would ignore A-records with wrong kind values, and lacking
TXT entries, but obviously I see cases where still present lookups
do use faulty premisses.)

None of the "free service" DNS BLs appear to have very long life-times.
The technology has some usefull ideas behind it, but alas once some
free service becomes popular, it is prone to overload, receive litigation
threats ("wonderfull" usa..) and fold over.  Often the folding is
accompanied with a period of poisoned datasets.

/Matti Aarnio -- co-postmaster of vger.kernel.org
