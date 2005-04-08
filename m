Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVDHL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVDHL5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVDHL5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:57:50 -0400
Received: from smtp05.web.de ([217.72.192.209]:58861 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261688AbVDHL5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:57:46 -0400
Subject: [BUG] 2.6.12-rc1/rc2 mouse0 became mouse1
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 08 Apr 2005 13:58:12 +0200
Message-Id: <1112961492.1618.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This doesn't sound right to me. After upgrading from 2.6.11.5/6 to
2.6.12-rc1/rc2 I detected that my mouse didn't operate anymore when
loading up XOrg, I realized that /dev/input/mouse0 (which worked for
years) had to be changed to /dev/input/mouse1. Anyone care to explain
why this had to be changed or what the intention behind this was ?

greetings,

Ali Akcaagac


