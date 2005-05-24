Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVEXGeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVEXGeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 02:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEXGeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 02:34:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8141 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261353AbVEXGep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 02:34:45 -0400
Message-ID: <4292CB01.6090506@pobox.com>
Date: Tue, 24 May 2005 02:34:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I don't understand why you don't use different trees, like you did with
> BK. You can share the object directory with the different trees, but the

You really can't beat

	cp .git/refs/heads/master .git/refs/heads/new-branch

as the fastest way to create a new branch off the tip.

	Jeff


