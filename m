Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932995AbWFZUBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbWFZUBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWFZUBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:01:21 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:55983 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932995AbWFZUBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:01:20 -0400
Date: Mon, 26 Jun 2006 22:01:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
Message-ID: <20060626200107.GA777@mars.ravnborg.org>
References: <87psh3mnay.fsf@hades.wkstn.nix> <87mzbzhk9y.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzbzhk9y.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 06:57:45PM +0100, Nix wrote:
> On 21 Jun 2006, nix@esperi.org.uk stipulated:
> > It didn't take long to work out that this was because my initramfs's
> > contents were being included twice in the cpio image.
> 
> Ping? Anyone?
It is included in kbuild.git - and Linus has been asked to pull that
tree. It is also forwarded to stable@kernel.org for inclusion in next
stable release.

	Sam
