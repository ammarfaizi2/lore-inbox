Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUFXUiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUFXUiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFXUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:38:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:38927 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265544AbUFXUgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:36:53 -0400
Date: Thu, 24 Jun 2004 22:49:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
Message-ID: <20040624204952.GA4700@mars.ravnborg.org>
Mail-Followup-To: Patrick McFarland <diablod3@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20040624203043.GA4557@mars.ravnborg.org> <d577e569040624132413451e20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d577e569040624132413451e20@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:24:01PM -0400, Patrick McFarland wrote:
> On Thu, 24 Jun 2004 22:30:43 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > 
> > The last couple of kbuild patches has put attention to testing for
> > features in the kernel so an external modules can stay compatible
> > with a broad range of kernels.
> > Since vendors backport patches then testing for the kernel version is not
> > an option, so other means are reqired.
> > 
> > Two approaches are in widespread use:
> > a) grep kernel headers
> > b) Try to compile a small .c file (nvidia is a good example)
> 
> Why can't you check the .config file to see if features are enabled?

Features in a broad sense so API changes with respect to types
and function calls

	Sam
