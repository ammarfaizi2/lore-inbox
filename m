Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVC1UDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVC1UDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVC1UDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:03:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:51361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262024AbVC1UD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:03:29 -0500
Date: Mon, 28 Mar 2005 12:02:52 -0800
From: Chris Wright <chrisw@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isofs: unobfuscate rock.c
Message-ID: <20050328200252.GN28536@shell0.pdx.osdl.net>
References: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pekka Enberg (penberg@cs.helsinki.fi) wrote:
> This patch removes macro obfuscation from fs/isofs/rock.c and cleans it up
> a bit to make it more readable and maintainable. There are no functional
> changes, only cleanups. I have only tested this lightly but it passes
> mount and read on small Rock Ridge enabled ISO image.

You might want to look at current -mm.  Andrew has a series or 13 or so
patches that do very similar cleanup.  Perhaps you could start from there?

thanks,
-chris
