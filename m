Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVCIS71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVCIS71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVCIS70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:59:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:18122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262163AbVCIS7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:16 -0500
Date: Wed, 9 Mar 2005 10:58:34 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, eric@lammerts.org
Subject: Re: [patch 1/5] cramfs: small stat(2) fix
Message-ID: <20050309185834.GB27268@kroah.com>
References: <200503042117.j24LHFox017964@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHFox017964@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:54PM -0800, akpm@osdl.org wrote:
> 
> From: Eric Lammerts <eric@lammerts.org>
> 
> When I stat(2) a device node on a cramfs, the st_blocks field is bogus
> (it's derived from the size field which in this case holds the major/minor
> numbers).  This makes du(1) output completely wrong.
> 
> Signed-off-by: Eric Lammerts <eric@lammerts.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Added to the -stable queue, thanks.

greg k-h
