Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270455AbTHGUkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHGUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:40:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10999 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270455AbTHGUkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:40:21 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 22:40:20 +0200 (MEST)
Message-Id: <UTC200308072040.h77KeKX04755.aeb@smtp.cwi.nl>
To: andries.brouwer@cwi.nl, jasper@vs19.net
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Jasper Spaans <jasper@vs19.net>

	... changes all occurrences of 'flavour' to 'flavor' 

	Andries, I did a small check if mount uses the fieldnames from
	the kernel headers, which doesn't seem to be the case, can you
	confirm this?

[was this an email mixup?]

Am not sure what you are asking, but if you mean things like
MS_RDONLY, no, these come from a private include file.
As you know user space utilities cannot easily use kernel includes.

Andries
