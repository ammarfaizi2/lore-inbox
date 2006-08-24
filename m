Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWHXJSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHXJSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWHXJSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:18:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30874 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750940AbWHXJSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:18:23 -0400
Subject: Re: Serial custom speed deprecated?
From: David Woodhouse <dwmw2@infradead.org>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <028a01c6c6fc$e792be90$294b82ce@stuartm>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 10:18:21 +0100
Message-Id: <1156411101.3012.15.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 17:41 -0400, Stuart MacDonald wrote:
> If custom speeds are deprecated, what's the new method for setting
> them? Specifically, how can the SPD_CUST functionality be accomplished
> without that flag? I've checked 2.5.64 and 2.6.17, and don't see how
> it is possible. 

We need a way to set the baud rate as an _integer_ instead of the Bxxxx
flags.

-- 
dwmw2

