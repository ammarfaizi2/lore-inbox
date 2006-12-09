Return-Path: <linux-kernel-owner+w=401wt.eu-S1759722AbWLIXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759722AbWLIXIK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 18:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759725AbWLIXIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 18:08:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34291 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722AbWLIXIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 18:08:09 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457B41CB.8080604@s5r6.in-berlin.de>
Date: Sun, 10 Dec 2006 00:07:55 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] Fix numerous kcalloc() calls, convert to kzalloc().
References: <Pine.LNX.4.64.0612090950580.14897@localhost.localdomain> <457B3346.2020008@s5r6.in-berlin.de> <Pine.LNX.4.64.0612091710250.8007@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612091710250.8007@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> drop me a note when the grown-ups are back in charge.

(You could have also explained where I erred. If I was in charge in
the first place, that is.)

Sure enough, this *alloc() stuff is easier to work with than e.g. the
recent workqueue changes.
-- 
Stefan Richter
-=====-=-==- ==-- -=--=
http://arcgraph.de/sr/
