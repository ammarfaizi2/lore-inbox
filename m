Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEHPtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTEHPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:49:55 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:2714 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S261688AbTEHPty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:49:54 -0400
Date: Thu, 8 May 2003 08:59:52 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305081559.h48FxqF07117@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: joern@wohnheim.fh-wedel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
>For the kernel or the main CPU, the driver firmware is just data. The
>same, as the magic 0x12345678ul that gets written to some register
>because [can't tell, NDA]. In both cases, magic data gets written
>somewhere and afterwards, things just work.

	I think you are confusing "the preferred form of the work
for making modifications to it" (the GPL's definition of "source
code") with "documentation."  In the case of poking a few values,
the preferred form for making modifications may be actually editing
the numbers directly in source code.  That quite likely is the way
that all developers maintain and modify that code, even if doing so
in an effective manner requires additional documentation.

	In comparison, with the binary blobs of firmware, the preferred
form of the work for making modifications is, presumably, to edit
a source file from which the binary blob can be rebuilt using an
assembler or compiler.

	I am not a lawyer.  Please do not use this as legal advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
