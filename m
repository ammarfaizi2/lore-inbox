Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUAXNel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 08:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266935AbUAXNel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 08:34:41 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:20096 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S264889AbUAXNel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 08:34:41 -0500
Date: Sat, 24 Jan 2004 12:58:43 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Special promisc receive mode
Message-ID: <20040124125843.B453@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I need to tell kernel that e. g. eth0 is a point-to-point link and that every
ethernet frame should be treated this way:
1) Replace destination MAC with MAC of the eth0 network card
2) Process as normally

I tried to set up promisc mode but it seems to not work - it looks like the
frames are intercepted, however are not treated as destinated for my host (are
not forwared etc.)

Cl<
