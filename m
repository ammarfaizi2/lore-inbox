Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUH0Kzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUH0Kzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUH0Kzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:55:54 -0400
Received: from main.gmane.org ([80.91.224.249]:56777 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261405AbUH0Kzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:55:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] make swsusp produce nicer screen output
Date: Fri, 27 Aug 2004 12:55:41 +0200
Message-ID: <412F132D.3000606@suse.de>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu> <20040824214929.GA490@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Pavel Machek <pavel@suse.cz>
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
In-Reply-To: <20040824214929.GA490@openzaurus.ucw.cz>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 

>>And do we need to handle the case when nr_copy_pages < 100?
> > 
> It really should not crash. 100 pages is 4MB. Thats little low but
> seems possible.

400k IIUC :-), and although it seems impossible, we still should not 
crash if we counted it wrong for some strange reason.

> 				Pavel

Stefan

