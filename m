Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264200AbUEDCdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbUEDCdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 22:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbUEDCdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 22:33:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:3802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264200AbUEDCdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 22:33:35 -0400
Date: Mon, 3 May 2004 19:32:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: wcatlan@yahoo.com, willy@w.ods.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Message-Id: <20040503193205.2004f249.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill,

(replying to:  http://lkml.org/lkml/2004/5/3/124,
I don't have mailbox access to your email ATM)


I wish that I had a way to test this patch.
Apparently Willy does, so I recommend his patch.... :)
with one change:

change
+static int setuptime;	/* time(ms) to let devices set up before root mount */

to
+static int setuptime = 10000;	/* time(ms) to let devices set up before root mount */


or 60000 (= 1 minute).  Whatever is comfortable for you.

Willy, it seems that some default value would be good there.

Later,
--
~Randy
