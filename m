Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWCWF7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWCWF7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWCWF7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:59:16 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:31465 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751127AbWCWF7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:59:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nWOA4Ie2BnE+l/pHk4B+jIQsWi/KXngprG3wOkBe8gSxw2kRMTiOV86HGnVRTWFAah6LKcIaWdXqPMqczajPsyInNpmqJH7VS3ZJfI9qkl4znDyKucmqoGnhTf/CazHZKyGFe0ij11O8TcUIf75MQ1wWgh+CedMLJZdXmu6rpC8=
Message-ID: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
Date: Thu, 23 Mar 2006 13:59:14 +0800
From: "Antonino Daplas" <adaplas@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for intelfb
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       sylvain.meyer@worldonline.fr, akpm@osdl.org
In-Reply-To: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Dave Airlie <airlied@gmail.com> wrote:
> This patch adds support for i915G, i915GM and i945G to the intelfb
> driver in the kernel.
>
> It comes from work done by me on an X.org driver to support some
> non-VBE modesetting.
>
> This code isn't perfect but I've got no documentation so I cannot
> answer some questions on what exactly is going on just yet...

Better than nothing, and if it works for digital displays, then that
would be great.

>
> The code is also available in the i915fb branch or
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6
>
> It may need more testing on the i945G, and I think adding i945GM
> support might only be a few lines of code...
>
> Is there a framebuffer git tree this could go in?

There's no git tree for the framebuffer layer, I just send updates
directly to akpm. Andrew?

Tony
