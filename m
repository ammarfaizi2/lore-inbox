Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbULCLRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbULCLRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbULCLRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:17:53 -0500
Received: from bigben.bytemark.co.uk ([212.13.210.58]:61152 "EHLO
	bigben.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S262156AbULCLRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:17:44 -0500
From: Fred Emmott <mail@fredemmott.co.uk>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [patch] make root_plug more useful via whitelist
Date: Fri, 3 Dec 2004 11:13:44 +0000
User-Agent: KMail/1.7.50
References: <200411272347.15728.mail@fredemmott.co.uk> <20041129164732.G14339@build.pdx.osdl.net>
In-Reply-To: <20041129164732.G14339@build.pdx.osdl.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031113.45489.mail@fredemmott.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New patch at http://files.fredemmott.co.uk/rp3.diff

Changes:
- No memory leak :) (as far as I'm aware)
- Haven't mucked up the diff this time (last time forgot the "-N")
- Can take serial number as a module parameter
- Debug output only included rejected processess - I'll probably change this 
back

Todo:
- Make the list of allowed process inode-based
- Make the list of allowed processes alterable via userspace; probably sysfs - 
I'm reading documentation on kobject...

-- 
Fred Emmott
(http://www.fredemmott.co.uk)
