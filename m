Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTENXZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTENXZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:25:36 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:30946 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263152AbTENXZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:25:35 -0400
Date: Thu, 15 May 2003 00:39:12 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Hans Reiser <reiser@namesys.com>, Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK] [PATCH] [2.4] ReiserFS export balance_dirty
Message-ID: <20030514233912.GA9898@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Hans Reiser <reiser@namesys.com>, Oleg Drokin <green@namesys.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EC28D47.4020909@namesys.com> <3EC2C2E3.8030007@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2C2E3.8030007@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:27:47AM +0200, Carl-Daniel Hailfinger wrote:
 > > +EXPORT_SYMBOL(balance_dirty);
 > 
 > Any reason why you don't put this in ksyms.c?
 > This is a honest question, no flamebait.

because it follows the style of the rest of fs/buffer.c

		Dave

