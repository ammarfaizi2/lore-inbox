Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVA1SJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVA1SJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVA1SJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:09:16 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:38085 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261504AbVA1SER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:04:17 -0500
Date: Fri, 28 Jan 2005 19:04:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050128180408.GA29635@wohnheim.fh-wedel.de>
References: <1106932637.3778.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1106932637.3778.92.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 January 2005 18:17:17 +0100, Lorenzo Hernández García-Hierro wrote:
> 
> Attached you can find a split up patch ported from grSecurity [1], as
> Linus commented that he wouldn't get a whole-sale patch, I was working
> on it and also studying what features of grSecurity can be implemented
> without a development or maintenance overhead, aka less-invasive
> implementations.

I can see why Linus isn't too excited about this patch:

o Increased entropy pool sizes are independent.  Should be a seperate
  patch.
o Huge numbers of #ifdef's in the code are Plain Wrong(tm).
o Replacing current randomization functions with new ones without
  lengthy explanation doesn't make me happy.

Also, if the patch was inline instead of an attachment, I could easily
quote it while commenting.


Not sure whether there are useful things in the patch, but in the
current form I wouldn't want to take it.  And usually I'm less picky
than Linus.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
