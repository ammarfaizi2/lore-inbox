Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbUB0UR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbUB0UQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:16:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:20133 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263116AbUB0UQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:16:26 -0500
X-Authenticated: #22280117
Date: Fri, 27 Feb 2004 21:19:09 +0100
From: Bernhard Gruber <bernig@gmx.at>
X-Mailer: The Bat! (v1.62 Christmas Edition) Personal
Reply-To: Bernhard Gruber <bernig@gmx.at>
X-Priority: 3 (Normal)
Message-ID: <12413031438.20040227211909@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
In-Reply-To: <185903078.20040227124512@gmx.at>
References: <185903078.20040227124512@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I think, we found out WHY it did not function with my trackpoint.
Actually, it was not the trackpoint but the fact, that I had compiled
in SMP-support into the kernel. I removed it and now the trackpoint
utilities work just fine! It's very likely, that this psaux-module
will work with ANY old driver/utility written for 2.4.X-kernels as
long as you follow the steps on the homepage and remove SMP-support!

