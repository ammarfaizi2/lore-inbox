Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWGJLiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWGJLiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGJLiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:38:06 -0400
Received: from canuck.infradead.org ([205.233.218.70]:12229 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751176AbWGJLiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:38:05 -0400
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup()
	static
From: David Woodhouse <dwmw2@infradead.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Adrian Bunk <bunk@stusta.de>, juha.yrjola@solidboot.com,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       jlavi@iki.fi
In-Reply-To: <44B23256.8030504@ru.mvista.com>
References: <20060626220215.GI23314@stusta.de>
	 <1151416141.17609.140.camel@hades.cambridge.redhat.com>
	 <20060629173206.GF19712@stusta.de>
	 <1152436332.25567.12.camel@shinybook.infradead.org>
	 <44B23256.8030504@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 12:37:33 +0100
Message-Id: <1152531453.3373.48.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 14:56 +0400, Sergei Shtylyov wrote:
>     In addition, this function might be needed to support parsing of the 
> partition info extracted from the OF device tree (if this way of storing it 
> there will be accepted)... 

Yes, we should extend physmap to handle of_devices and partition
information represented as a string. It won't be mtdpart_setup() which
we use for that though.

-- 
dwmw2

