Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbTLEWrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264581AbTLEWrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:47:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:19947 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264577AbTLEWrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:47:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
References: <200312041432.23907.rob@landley.net> <20031204214850.GG29119@mis-mike-wstn.matchmail.com> <200312041759.14385.rob@landley.net>
Organization: private Linux site, southern Germany
Date: Fri, 05 Dec 2003 23:42:34 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1ASOej-0005Kp-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was thinking of making a toy that would run periodically against a
> seldom-changed filesystem, find runs of zeroes of a certain minimum
> size, and turn 'em into holes. The fragmentation might not be worth
> it, though...

"cp" does that already. Hunt for sparse files, copy them and move the
new file to the old location.
There used to be an installer (Slackware, I think) back in very old
days which did this to every binary after untarring...

Olaf

