Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVIYJ1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVIYJ1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 05:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIYJ1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 05:27:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34767 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751001AbVIYJ1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 05:27:52 -0400
Date: Sun, 25 Sep 2005 11:27:00 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960: s/Controller/c/g
Message-ID: <20050925092700.GA21857@electric-eye.fr.zoreil.com>
References: <20050925001135.GD18795@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925001135.GD18795@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> :
> C is spartan language, dammit! Also, shrink driver by 12k.

ctrl and ctl are spartan too and they can hardly be confused with
a 'char' or a 'command', especially in functions which contain more
than 4 lines of code.

If you do not intend to maintain the driver on a regular basis,
the current patch is imho worthless.

--
Ueimor
