Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTEJU4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTEJU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:56:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14976 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S264506AbTEJU4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:56:39 -0400
Subject: Re: TRIVIAL: turn of AGP drivers which are not supported on ia64
From: David Woodhouse <dwmw2@infradead.org>
To: davidm@hpl.hp.com
Cc: davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200305100953.h4A9rnV8012151@napali.hpl.hp.com>
References: <200305100953.h4A9rnV8012151@napali.hpl.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052600952.1881.13.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sat, 10 May 2003 22:09:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-10 at 10:53, David Mosberger wrote:
>  #config AGP_I810
>  #	tristate "Intel I810/I815/I830M (on-board) support"
> -#	depends on AGP && !X86_64
> +#	depends on AGP && !X86_64 && !IA64

... it works on Alpha? Should this be 'AGP && i386' instead?

-- 
dwmw2

