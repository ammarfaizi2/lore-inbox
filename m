Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVEFM3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEFM3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEFM3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:29:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41869 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261196AbVEFM3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:29:49 -0400
Date: Fri, 6 May 2005 14:29:43 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, aebr@win.tue.nl,
       hubert.tonneau@fullpliant.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Message-ID: <20050506122943.GG25418@apps.cwi.nl>
References: <055UDZ711@server5.heliogroup.fr> <20050505161610.GA4604@pclin040.win.tue.nl> <20050505194342.5ecde856.akpm@osdl.org> <20050506111445.GC25418@apps.cwi.nl> <20050506044720.2bb95792.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506044720.2bb95792.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 04:47:20AM -0700, Andrew Morton wrote:

> How about the old fallback?
> 
> So add a new boot option `msdos_skip_null_part' to enable this workaround.

Oh, horrors! Andrew, you do not want this.
This is much worse than leaving that patch or removing it.

Options are evil.
In this particular case options are terrible.

Andries
