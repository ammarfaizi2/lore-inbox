Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUAXTZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAXTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 14:25:57 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:55518 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261807AbUAXTZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 14:25:56 -0500
Date: Sat, 24 Jan 2004 21:25:45 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-ID: <20040124192545.GW11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Arjan van de Ven <arjanv@redhat.com>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20040124181026.GA22100@codeblau.de> <1074968776.4442.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074968776.4442.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 07:26:17PM +0100, you [Arjan van de Ven] wrote:
> 
> I recently did something like this (and it scared me, it seems a typical
> Fedora boot into gnome opens like 11.000 files ;) but via a printk in
> the kernel....
> 
> I experimented with readahead'ing all that stuff while the initscripts
> ran in the hope it would save time... but it doesn't somehow.

Did you sort the sectors to be read, or just read the files into page cache
in randomish order ?

Or do you mean that even after all the files were read into cache, the X
startup time didn't get any better (not counting the cache priming)?

 
-- v --

v@iki.fi
