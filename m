Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUAOOvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUAOOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:51:36 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:20499 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263946AbUAOOvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:51:35 -0500
Date: Thu, 15 Jan 2004 15:51:31 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Manning <jmm@sublogic.com>
Subject: Re: [PATCH] linux-2.6.0-test3 - remove a few remaining "make dep" references (fwd)
Message-ID: <20040115145131.GA1660@win.tue.nl>
References: <20040115130555.GA23383@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115130555.GA23383@fs.tum.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:05:56PM +0100, Adrian Bunk wrote:

> -# Note! Dependencies are done automagically by 'make dep', which also
> -# removes any old dependencies. DON'T put your own dependencies here
> +# Note! DON'T put your own dependencies here
>  # unless it's something special (ie not a .c file).
>  #
>  # Note 2! The CFLAGS definition is now in the main makefile...

If you are going to touch all Makefiles anyway, you could consider
removing all of this text everywhere.

Andries

