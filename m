Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUFXUYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUFXUYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUFXUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:24:04 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:15769 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265501AbUFXUYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:24:02 -0400
Message-ID: <d577e569040624132413451e20@mail.gmail.com>
Date: Thu, 24 Jun 2004 16:24:01 -0400
From: Patrick McFarland <diablod3@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: RFC: Testing for kernel features in external modules
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040624203043.GA4557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040624203043.GA4557@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 22:30:43 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> The last couple of kbuild patches has put attention to testing for
> features in the kernel so an external modules can stay compatible
> with a broad range of kernels.
> Since vendors backport patches then testing for the kernel version is not
> an option, so other means are reqired.
> 
> Two approaches are in widespread use:
> a) grep kernel headers
> b) Try to compile a small .c file (nvidia is a good example)

Why can't you check the .config file to see if features are enabled?

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
