Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUBYP2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBYP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:28:10 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:28819 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261367AbUBYP2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:28:06 -0500
Date: Wed, 25 Feb 2004 10:17:51 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, christophe@saout.de,
       linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225151751.GC3852@certainkey.com>
References: <20040224220030.13160197.akpm@osdl.org> <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 08:27:49AM -0500, James Morris wrote:
> > If practical this API should have been defined in terms of
> > (page/offset/len) and it should have kmapped the pages itself.  I guess
> > it's too late for that.
> 
> Do you mean that the crypt() function should do kmapping?
> 
> It's not too late to change internals.

Can I get an example of how to do this with scatterlists?

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
