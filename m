Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUKWUAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUKWUAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUKWT7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:59:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:17482 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261583AbUKWT4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:56:34 -0500
Date: Tue, 23 Nov 2004 20:56:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v2][4/21] Add InfiniBand MAD (management datagram) support (public headers)
Message-ID: <20041123195654.GD8367@mars.ravnborg.org>
Mail-Followup-To: Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <20041123814.LeHMD5hRZLn6VbLm@topspin.com> <20041123814.xOcI2C4YpT1G9jQi@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123814.xOcI2C4YpT1G9jQi@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:14:31AM -0800, Roland Dreier wrote:
> +
> +struct ib_grh {
> +	u32		version_tclass_flow;
> +	u16		paylen;
> +	u8		next_hdr;
> +	u8		hop_limit;
> +	union ib_gid	sgid;
> +	union ib_gid	dgid;
> +} __attribute__ ((packed));

It was told on lkml why these structs was packed.
Same info here as comment so it is known next time.

And I see comments to API here - good.

	Sam
