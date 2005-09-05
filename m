Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVIESdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVIESdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVIESc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:56 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:45411 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932378AbVIEScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:52 -0400
Message-Id: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:09 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 00/10] parport: ieee1284 fixes and cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I played with a daisy chain device that is not ieee1284 compliant
and found buffer overflow and failure to open daisy chain devices.
While fixing it I found also a number of other problems also affecting
proper ieee1284 devices.

This is a collection of the changes I have made. They have been through
linux-parport mailing list already in January and they have been modified
according to comments.

--
