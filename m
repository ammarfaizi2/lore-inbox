Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUEUXdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUEUXdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbUEUXao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:30:44 -0400
Received: from mail.zmailer.org ([62.78.96.67]:44237 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264822AbUEUXSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:18:34 -0400
Date: Sat, 22 May 2004 02:18:33 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Network problems affecting sending email to VGER ...
Message-ID: <20040521231833.GN1749@mea-ext.zmailer.org>
Reply-To: postmaster@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

There is something weird going on near VGER, which appears
to cause _inbound_ SMTP protocol sessions to hang every now
and then.  (Rather often in fact..)

So far network dump investigations are telling, that something
is corrupting outbound data frames somewhere in the network.
A router next to VGER is suspected.

Also it does look like Linuxes (2.4/2.6 at least) are mostly
immune to the problem, so are also Solaris 2.8 systems, while
Solaris 2.6/2.7 hang.

Hardware vendors have been contacted, and high priority trouble-
tickets have been opened...

/Matti Aarnio

PS: When you want to contact VGER's admins about email issues,
    DO use the  <postmaster@vger.kernel.org>  address.
    Not our personal ones, nor e.g. webmaster address...
