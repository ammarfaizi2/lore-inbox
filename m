Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWAQR5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWAQR5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWAQR5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:57:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:26126 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932276AbWAQR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:57:16 -0500
Message-ID: <43CD2FDF.8080006@shadowen.org>
Date: Tue, 17 Jan 2006 17:56:47 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zonelists gfp_zone() is really gfp_zonelist()
References: <20060117155010.GA16135@shadowen.org> <1137519100.5526.11.camel@localhost.localdomain>
In-Reply-To: <1137519100.5526.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> Hmm, but it's not really a zonelist, either.  It's an index into an
> array of zonelists that gets you a zonelist.  How about
> gfp_to_zonelist_nr()?

Sounds fair, I'll respin the patch with a better name.

-apw
