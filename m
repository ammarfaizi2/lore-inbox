Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVAQVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVAQVpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVAQVpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:45:42 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:24846 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261364AbVAQVpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:45:35 -0500
Date: Mon, 17 Jan 2005 16:44:22 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050117214420.GH4348@tuxdriver.com>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20050117183708.GD4348@tuxdriver.com> <20050117203930.GA9605@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117203930.GA9605@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 07:39:30AM +1100, Herbert Xu wrote:
> On Mon, Jan 17, 2005 at 01:37:08PM -0500, John W. Linville wrote:
> > "Some" OSS applications have trouble with later versions of the
> > i810_audio driver.  Wolfenstein Enemy Territory from idSoftware is
> > one such application.
> 
> Would it be possible to create a minimal program (something that triggers
> a start through __i810_update_lvi) that reproduces this problem?

Possible is, of course, somewhat relative... :-)  I'm not immediately
equipped to produce such a program.

Enemy Territory is available for free (as in beer) download from
www.enemy-territory.com.  Sound plays almost immediately once the
game is started.

Is this sufficient?

John
-- 
John W. Linville
linville@tuxdriver.com
