Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVANPHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVANPHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVANPHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:07:22 -0500
Received: from orb.pobox.com ([207.8.226.5]:1972 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262005AbVANPHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:07:18 -0500
Date: Fri, 14 Jan 2005 07:07:14 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net>
References: <20050114002352.5a038710.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't new to 2.6.11-rc1-mm1, but it has the infamous (to Fedora
users) "ACPI shutdown bug" -- poweroff hangs instead of actually turning
the computer off, on some computers. Here's the RH Bugzilla report where
most of the discussion took place:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132761                     

In the Fedora kernels it turned out to be due to kexec. I'll see if I
can narrow it down further.

-Barry K. Nathan <barryn@pobox.com>

