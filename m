Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUHQV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUHQV7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUHQV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:59:42 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:50128 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S266786AbUHQV7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:59:41 -0400
Date: Tue, 17 Aug 2004 23:59:40 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
Message-ID: <20040817215940.GA13576@janus>
References: <20040817103852.GA18758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817103852.GA18758@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 12:38:52PM +0200, Pavel Machek wrote:
> Hi!
> 
> -	} while (0)
> +	} while(0)

"while" is not a function so I'd keep the space. Both coding style
and kernel/*.c (had to pick something) seem to agree upon this: put
a space between keyword and expression.

-- 
Frank
