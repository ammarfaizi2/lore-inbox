Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTFSP4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbTFSP4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:56:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265824AbTFSP4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:56:16 -0400
Subject: 2.5.72: wall-clock time advancing too rapidly?
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Jun 2003 09:10:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a uniproc P3-800 system running 2.5.72, and time (from that
system's point of view) is racing ahead rapidly.

By "racing ahead rapidly", I mean this:

	% date ; sleep 60 ; date
	Thu Jun 19 09:04:29 PDT 2003
	Thu Jun 19 09:05:29 PDT 2003
	%

returns in 35 seconds (measured with my eyeballs and cheap wristwatch).

Has anyone else seen this?

Regards,
Andy


