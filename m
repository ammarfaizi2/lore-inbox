Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWHXPpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWHXPpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWHXPpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:45:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22966 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751598AbWHXPpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:45:15 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824152937.GK19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com>
	 <20060824152937.GK19810@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:44:34 +0100
Message-Id: <1156434274.3012.128.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
>         bool "Enable the block layer" depends on EMBEDDED 

Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
sole purpose is to pander to Aunt Tillie.

-- 
dwmw2

