Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbTFVS7F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbTFVS7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:59:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39693 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265783AbTFVS7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:59:00 -0400
Date: Sun, 22 Jun 2003 21:12:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030622191252.GA1406@mars.ravnborg.org>
Mail-Followup-To: "Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622103251.158691c3.akpm@digeo.com> <bd4u7s$jkp$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4u7s$jkp$1@tangens.hometree.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 06:58:04PM +0000, Henning P. Schmiedehausen wrote:
> Andrew Morton <akpm@digeo.com> writes:
> 
> Your problem is not the compiler but the build tool / system which
> forces you to recompile all of your kernel if you change only small
> parts.

If you know of any cases where too much is build after a change in
the 2.5 kernel I would like to know that.

In the above keep in mind that the finest granularity is on a file basis,
except for .config, where it is on a config entry granularity.

	Sam
