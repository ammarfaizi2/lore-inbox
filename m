Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbUKOXPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUKOXPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKOXPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:15:06 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:38858 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S261601AbUKOXNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:13:15 -0500
Date: Mon, 15 Nov 2004 18:13:06 -0500 (EST)
From: Nickolai Zeldovich <kolya@MIT.EDU>
To: David Weinehall <tao@acc.umu.se>
cc: linux-kernel@vger.kernel.org, csapuntz@stanford.edu
Subject: Re: [patch] Fix GDT re-load on ACPI resume
In-Reply-To: <20041115230249.GR29980@khan.acc.umu.se>
Message-ID: <Pine.GSO.4.58L.0411151809220.3765@contents-vnder-pressvre.mit.edu>
References: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
 <20041115230249.GR29980@khan.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, David Weinehall wrote:

> Sadly doesn't work for me.  ACPI resume broke for me with
> 2.6.10-rc1-bk15 (possibly 14, but that one didn't compile), and this
> patch does not fix it.

For the record, the symptoms of the problem fixed by the GDT patch in
question are that, upon ACPI resume, your screen shows the letters "Lin"
in yellow, hangs for a little bit, and then reboots.

-- kolya
