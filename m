Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVLIP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVLIP2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVLIP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:28:36 -0500
Received: from cantor.suse.de ([195.135.220.2]:18102 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964774AbVLIP2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:28:33 -0500
Date: Fri, 9 Dec 2005 16:28:32 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209152832.GA26963@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209151348.GA12815@nevyn.them.org> <20051209151914.GA26653@suse.de> <20051209152625.GA13287@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051209152625.GA13287@nevyn.them.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 09, Daniel Jacobowitz wrote:

> Maybe I'm misunderstanding your patch, but the issue is that you've
> just made the serial console not-eight-bit-clean.

True. Have to throw more stuff in the if() for this part of the issue.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
