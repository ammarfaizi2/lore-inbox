Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTHQRuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTHQRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:50:24 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:13840 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S270448AbTHQRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:50:23 -0400
Subject: Can't run Quake 3 on 2.6.0-test3-mm2
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061142481.14239.7.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 13:49:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently upgraded to 2.6.0-test3-mm2 and part of my normal testing
involves a quick run of q3demo.  Under this kernel the system segfaults
when attempting to run this program.  Running strace I was able to
determine that this fails when it attempts to open the pak0.pk3 as
readonly.  Booting back to 2.6.0-test2-mm1 and the same program
continues to work perfectly.

Any ideas what might be going on here?  I haven't found any other
applications that exhibit such strange behavior but I'm still testing.

Later,
Tom


