Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUAVI2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAVI2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:28:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21255 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266017AbUAVI2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:28:11 -0500
Date: Thu, 22 Jan 2004 08:28:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Export console functions for use by Software Suspend nice display
Message-ID: <20040122082809.A7699@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1074757083.1943.37.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1074757083.1943.37.camel@laptop-linux>; from ncunningham@users.sourceforge.net on Thu, Jan 22, 2004 at 09:12:00PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:12:00PM +1300, Nigel Cunningham wrote:
> Hi.
> 
> Here's a second patch; this exports gotoxy, reset_terminal, hide_cursor,
> getconsxy and putconsxy for use in Software Suspend's nice display.

Really, swsusp shouldn't mess with console internals.  And you don't even
explain what "nice display" is supposed to mean.

