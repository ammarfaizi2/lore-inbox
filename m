Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUIAANe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUIAANe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIAANY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:13:24 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:55976 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269128AbUIAANE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:13:04 -0400
Date: Wed, 1 Sep 2004 11:07:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic (probably XFS related)
Message-ID: <20040901010759.GA1028@frodo>
References: <17776.1093949281@trentino.logica.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17776.1093949281@trentino.logica.co.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 12:48:01PM +0200, Oliver Kiddle wrote:
> I'm still having problems with the machine where I previously posted
> about page allocation failures. I recently tried upgrading to 2.6.8.1
> and it has now crashed twice. When running 2.6.3 the machine is stable:
> just the error messages I previously posted about.
> 
> Firstly, with 2.6.8.1, I get a number of these messages but they don't
> seem to be fatal:
>   pagebuf_get: failed to lookup pages

They aren't fatal, they're just warnings.  In earlier versions
we had an XFS bug here, thats been fixed in kernels after 2.6.7.

cheers.

-- 
Nathan
