Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWGLPMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWGLPMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGLPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:12:51 -0400
Received: from xenotime.net ([66.160.160.81]:64469 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751396AbWGLPMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:12:49 -0400
Date: Wed, 12 Jul 2006 08:15:35 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: resource_size_t and printk()
Message-Id: <20060712081535.296ea579.rdunlap@xenotime.net>
In-Reply-To: <44B4B041.9050808@drzeus.cx>
References: <44AAD59E.7010206@drzeus.cx>
	<20060704214508.GA23607@kroah.com>
	<44AB3DF7.8080107@drzeus.cx>
	<20060711231537.GC18973@kroah.com>
	<44B4B041.9050808@drzeus.cx>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 10:18:09 +0200 Pierre Ossman wrote:

> Greg KH wrote:
> > Good catch, care to create a patch to fix these?
> >   
> 
> Included.

ugh :(

I know it's more wordy, but we usually use
(unsigned long long), not just (long long).

Wish we had an abbreviation for that.

---
~Randy
