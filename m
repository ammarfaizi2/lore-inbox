Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVDFB3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDFB3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVDFB3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:29:30 -0400
Received: from mail58-s.fg.online.no ([148.122.161.58]:31922 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261760AbVDFB3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:29:24 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: linux-kernel@vger.kernel.org
Subject: Coding style: mixed-case
Date: Wed, 6 Apr 2005 03:29:21 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060329.21469.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while reading Documentation/CodingStyle for the nth time, I realized that I had
read some conflicting coding style in some patch posted to the linux-kernel
mailing-list; in include/linux/page-flags.h, there is a lot of defines that are
apparently frowned upon:

HOWEVER, while mixed-case names are frowned upon, descriptive names for
global variables are a must.  To call a global function "foo" is a
shooting offense.

Are those an exception to the rule or would for example PF_LOCKED/pf_locked be
a nice replacement for PageLocked?

Just wondering; with no intention to change code that I do not understand :)

Kenneth
