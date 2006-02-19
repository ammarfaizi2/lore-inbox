Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWBSV4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWBSV4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWBSV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:56:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932102AbWBSV4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:56:11 -0500
Subject: Re: kernel panic with unloadable module support... SMP
From: Arjan van de Ven <arjan@infradead.org>
To: George P Nychis <gnychis@cmu.edu>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
	 <20060219191552.GB4971@stusta.de>
	 <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 22:56:04 +0100
Message-Id: <1140386164.6514.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 16:27 -0500, George P Nychis wrote:
> Okay, I downloaded the 2.6.16-r4 kernel and left it unmodified and I do not get the panic.
> 
> Can you suggest anything for me so that I can find what is causing the panic with the gentoo vanilla sources?
> 
> http://www.andrew.cmu.edu/user/gnychis/dsc00257.jpg


most of the time that I see this this oops signature the cause is a
mismatch in regparm-ness of a module and the kernel.... (see
CONFIG_REGPARM)

