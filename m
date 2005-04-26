Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVDZB5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDZB5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDZB5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:57:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261196AbVDZB5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 21:57:14 -0400
Date: Mon, 25 Apr 2005 18:53:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] change the SOUND_PRIME handling
Message-Id: <20050425185342.50ac4397.akpm@osdl.org>
In-Reply-To: <20050415004845.GI20400@stusta.de>
References: <20050415004845.GI20400@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> SOUND_PRIME (for OSS) is a tristate.
> 
>  This doesn't make much sense if most users are checking for 
>  SOUND_PRIME!=0.
> 
>  This patch changes the semantics of SOUND_PRIME to being a limit for all 
>  OSS modules, IOW: SOUND_PRIME=m does now say that all OSS drivers can 
>  only be modular.
> 
>  As a side effect, since SOUND_PRIME already depends on SOUND, there's no 
>  longer a reason for drivers depending on SOUND_PRIME to additionally 
>  depend on SOUND.

This spits lots of rejects because it had dependencies on Sam's trees and
I've dropped all bk trees.  Please fix it up in a week or three.

