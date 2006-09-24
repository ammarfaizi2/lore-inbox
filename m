Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWIXIvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWIXIvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWIXIvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:51:53 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:16037 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751799AbWIXIvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:51:52 -0400
Date: Sun, 24 Sep 2006 10:57:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][BUILD] Fix "mkdir -p" usage in scripts/package/mkspec
Message-ID: <20060924085704.GA22464@uranus.ravnborg.org>
References: <200608140816.48030.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608140816.48030.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 08:16:47AM +0200, Rolf Eike Beer wrote:
> "mkdir -p" does not only mean not to complain if the directory already
> exists, but also to create the parent directories if needed. This patch
> removes "lib" from the list of directories to create as we will also create
> "lib/modules".

Applied,

	Sam
