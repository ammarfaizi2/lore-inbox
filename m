Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTI2TNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTI2TNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:13:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20241 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264515AbTI2TN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:13:29 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test6
Date: 29 Sep 2003 19:04:02 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bl9vn1$37p$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030929135540.GO29313@actcom.co.il> <Pine.LNX.4.53.0309291558550.1362@pnote.perex-int.cz> <20030929141800.GP29313@actcom.co.il>
X-Trace: gatekeeper.tmr.com 1064862242 3321 192.168.12.62 (29 Sep 2003 19:04:02 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030929141800.GP29313@actcom.co.il>,
Muli Ben-Yehuda  <mulix@mulix.org> wrote:

| I think it's a build system issue and thus should be handled by the
| build system, not by #ifdefs. However, if that's the way you prefer
| it, here's a patch to remove the GAMEPORT dependencies from
| sound/pci/Kconfig. From a quick glance, all affected drivers have the
| necessary ifdefs.=20

Yes, I think there are people who would like working sounds who don't
play games. It's totally inobvious that you need to configure gameport
support to get sound on the menu.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
