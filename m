Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWHACoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWHACoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWHACoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:44:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:46733 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751529AbWHACoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:44:16 -0400
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] x86_64 built-in command line
Date: Tue, 1 Aug 2006 04:44:04 +0200
User-Agent: KMail/1.9.3
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060731171442.GI6908@waste.org> <44CEBEAF.8030203@zytor.com> <20060801024102.GS6908@waste.org>
In-Reply-To: <20060801024102.GS6908@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010444.04681.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 04:41, Matt Mackall wrote:
> On Mon, Jul 31, 2006 at 07:38:39PM -0700, H. Peter Anvin wrote:
> > Actually, the best thing to do might be to designate a symbol (say &, 
> > like in automount) as "insert the boot loader command line here."
> > 
> > That way you can specify things in the builtin command line that are 
> > both prepended and appended to the boot loader command, and if you wish, 
> > you can emit it completely.
> > 
> > The default would be just "&".
> 
> That idea doesn't suck. I'll take a look at it.

With %s it would be much less code to write.

-Andi
