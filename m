Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUAFDcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUAFDcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:32:47 -0500
Received: from fmr99.intel.com ([192.55.52.32]:2197 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S265316AbUAFDcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:32:47 -0500
Date: Tue, 6 Jan 2004 11:26:44 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: "Zhu, Yi" <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840254C8C3@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0401061125400.26383-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Marcos D. Marado Torres wrote:

> >         if (!offset || !atomic_read(&map->nr_free)) {
> > +               if (!offser)
> 
> I suppose it should be "if (!offset)"...

Yes, my mistake. Thanks!

