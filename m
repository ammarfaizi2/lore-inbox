Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272303AbTHKIyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272318AbTHKIyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:54:54 -0400
Received: from web40509.mail.yahoo.com ([66.218.78.126]:43554 "HELO
	web40509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272303AbTHKIyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:54:54 -0400
Message-ID: <20030811085453.71881.qmail@web40509.mail.yahoo.com>
Date: Mon, 11 Aug 2003 01:54:53 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Warnings building 2.4.22rc2 with gcc 3.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I build 2.4.22rc2 with gcc 3.3, I get the following warnings


vt.c:166: warning: comparison is always false due to limited range of data type
vt.c:283: warning: comparison is always false due to limited range of data type
keyboard.c:644: warning: comparison is always true due to limited range of data type

It seems an unsigned char is being compared with 256, which always returns false.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
