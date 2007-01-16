Return-Path: <linux-kernel-owner+w=401wt.eu-S1751654AbXAPVQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXAPVQA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXAPVQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:16:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:60259 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbXAPVQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:16:00 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attribute removal patch causes lockdep warning
Date: Tue, 16 Jan 2007 22:15:57 +0100
User-Agent: KMail/1.9.1
Cc: Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701161139450.2276-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701161139450.2276-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701162215.57758.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Januar 2007 21:33 schrieb Alan Stern:
> Are you aware that your patch for safe attribute file removal provokes a 
> lockdep warning at bootup?

Yes, I am aware of that. However, the top down lock order is always
followed. A patch to make the lock checker realize that has been posted
and included upstream.

	Regards
		Oliver
