Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUFNU6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUFNU6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNU6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:58:30 -0400
Received: from levante.wiggy.net ([195.85.225.139]:9351 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264223AbUFNU62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:58:28 -0400
Date: Mon, 14 Jun 2004 22:58:27 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/5] kbuild: add deb-pkg target
Message-ID: <20040614205827.GD619@wiggy.net>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204602.GD15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204602.GD15243@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Sam Ravnborg wrote:
> +# Deb target
> +# ---------------------------------------------------------------------------
> +# 
> +.PHONY: rpm-pkg rpm
> +deb-pkg:

Shouldn't that .PHONY reference deb-pkg instead?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
