Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWJ2LPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWJ2LPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 06:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWJ2LPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 06:15:00 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:37845 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S932205AbWJ2LO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 06:14:59 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 29 Oct 2006 06:13:03 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: why test for "__GNUC__"?
Message-ID: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  since (as i understand it) the linux kernel *requires* gcc these
days, what is the point of the numerous preprocessor tests of the
form:

  #ifdef __GNUC__

and its variations?

  under the circumstances, aren't all those tests redundant?

rday
