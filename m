Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVAaHlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVAaHlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVAaHiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:38:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:675 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261961AbVAaHfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:07 -0500
Date: Mon, 31 Jan 2005 07:31:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Paul Blazejowski <diffie@gmail.com>,
       linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050131073151.GA7567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, Paul Blazejowski <diffie@gmail.com>,
	linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org> <20050130105738.GA28387@infradead.org> <20050130120009.GG3185@stusta.de> <20050130121241.GH3185@stusta.de> <Pine.LNX.4.61.0501302358270.6118@scrub.home> <20050130231055.GA7103@stusta.de> <Pine.LNX.4.61.0501310025360.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501310025360.6118@scrub.home>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 12:36:02AM +0100, Roman Zippel wrote:
> Why not just let XFS_FS select EXPORTFS directly:
> 
> config XFS_FS
> 	select EXPORTFS if NFSD

Makes sense.  We'll still need the XFS_EXPORT symbol in it's original
form to select building xfs_export.o.

