Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUA0B5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUA0B5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:57:06 -0500
Received: from hera.cwi.nl ([192.16.191.8]:49844 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261731AbUA0B5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:57:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 27 Jan 2004 02:56:44 +0100 (MET)
Message-Id: <UTC200401270156.i0R1uiR06609.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, gotom@debian.or.jp
Subject: Re: [uPATCH] refuse plain ufs mount
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From gotom@debian.or.jp  Tue Jan 27 02:44:00 2004

	I wonder this modification is really ok because user can't find why he
	can't mount his ufs if he does not specify ufstype=.  Putting only
	one line is not acceptable for you?

But you see, it wasn't the user at all, and it wasn't a ufs filesystem.
It is kernel probing that causes error messages. That is unwanted.
So, your version is wrong.

If it is really very desirable to warn the user the condition if(!silent)
should be added.

But in my opinion such a warning is not desirable at all.
mount(8) and Documentation/filesystems/ufs.txt explain the details.

Andries
