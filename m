Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWFMWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWFMWPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFMWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:15:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932289AbWFMWPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:15:23 -0400
Subject: Re: [PATCH -mm] i386 syscall opcode reordering (pipelining)
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e6nd68$4sq$1@terminus.zytor.com>
References: <20060613195446.GD24167@rhlx01.fht-esslingen.de>
	 <448F1B97.3070207@linux.intel.com>  <e6nd68$4sq$1@terminus.zytor.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 23:15:41 +0100
Message-Id: <1150236941.11159.125.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 15:11 -0700, H. Peter Anvin wrote:
> > is anybody actually EVER using those???
> > I would think not....
> 
> Probably not.  The _syscallN() macros are broken for the general case
> on any 32-bit architecture, since they can't handle multiregister
> arguments.

In the -mm tree they're no longer visible outside ifdef __KERNEL__.

-- 
dwmw2

