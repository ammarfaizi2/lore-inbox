Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLWS0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTLWS0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:26:14 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:55287 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262164AbTLWS0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:26:13 -0500
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Prevailence of PS/2 Active Muxed devices?
Date: Tue, 23 Dec 2003 13:25:39 -0500
User-Agent: KMail/1.5.4
References: <20031223180429.GA11198@dreamland.darkstar.lan>
In-Reply-To: <20031223180429.GA11198@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231325.39712.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have an application where I'd like to specifically control which PS/2 aux 
device data is sent/received from/to.  Particularly, on a laptop that has an 
integrated touch pad, I'd like to select the external mouse port.  

	This document http://www.synaptics-uk.com/decaf/utilities/ps2-mux.PDF 
describes what appears to be a rather well thought method for multiple aux 
devices on a single KBC.

	Looking through the kernel sources, I see no handling for this.  From a big 
picture perspective, how does Linux handle a system with an integrated mouse 
pad, and an external PS/2 mouse port?  Is this whole Synaptics idea dead, or 
is support for this planned, or even considered?  Does any one have any 
knowledge the number of KBCs with this muxing?  

	Seeing some of the parties that partcipated in the standards, it would be a 
touch surprising if it just completely died.

	--jc

