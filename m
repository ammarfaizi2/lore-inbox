Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWECQCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWECQCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWECQCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:02:06 -0400
Received: from canuck.infradead.org ([205.233.218.70]:62159 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030231AbWECQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:02:04 -0400
Subject: Re: [RFC] Advanced XIP File System
From: David Woodhouse <dwmw2@infradead.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Jared Hulbert <jaredeh@gmail.com>, Josh Boyer <jwboyer@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605031151120.28543@localhost.localdomain>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
	 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
	 <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
	 <1146658275.20773.8.camel@pmac.infradead.org>
	 <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
	 <Pine.LNX.4.64.0605031151120.28543@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 May 2006 17:01:58 +0100
Message-Id: <1146672118.20773.32.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 11:57 -0400, Nicolas Pitre wrote:
> First, is it worth it?

Quite possibly not. Even if you don't actually have kernel XIP, you may
well decide just not to schedule userspace while the flash isn't in READ
mode. Tearing down PTEs is painful.

-- 
dwmw2

