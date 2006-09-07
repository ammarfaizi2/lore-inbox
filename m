Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWIGM1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWIGM1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWIGM1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:27:38 -0400
Received: from natreg.rzone.de ([81.169.145.183]:39642 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1751575AbWIGM1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:27:37 -0400
Date: Thu, 7 Sep 2006 14:26:07 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols (v2)
Message-ID: <20060907122607.GA22882@aepfle.de>
References: <44FFEE5D.2050905@openvz.org> <20060907110513.GA22319@aepfle.de> <20060907111329.GI25473@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060907111329.GI25473@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, Adrian Bunk wrote:

> If any module shipped with the kernel has in any configuration 
> unresolved symbols that's a bug that should be reported, not ignored.

Yes, but on request when building the package. Not per default.
I probably missed the reason why this is now suddenly a problem.
