Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVCBOIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVCBOIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVCBOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:07:33 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21600 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262299AbVCBOGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:06:38 -0500
Message-ID: <4225C86C.8000502@tls.msk.ru>
Date: Wed, 02 Mar 2005 17:06:36 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050302124728.GD14002@mail.13thfloor.at>
In-Reply-To: <20050302124728.GD14002@mail.13thfloor.at>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
[]
> BUG_ON() and friends are still broken (at least on x86)
[]
> Freeing unused kernel memory: 244k freed
> ------------[ cut here ]------------
> kernel BUG at <bad filename>:9377!
> 	      ~~~~~~~~~~~~~~~~~~~

Have you tried compiling with CONFIG_DEBUG_INFO=y ?
(Looks like CONFIG_DEBUG_BUGVERBOSE should either
depend on CONFIG_DEBUG_INFO or turn it on).

/mjt
