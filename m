Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVKGR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVKGR3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbVKGR3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:29:23 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:52643 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965229AbVKGR2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:28:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lke4mF49VJZF68+1Div6WPVSRGL6Am/jn+zxi+MxwrGdVbaCWkGG8c38KIrjyGCYsSfwoHi1XKNnNyTO+qek38BpL5gIhgfLTYGWYEjhyIHjwtYipVgJekZbqXffvhgmP6lIvi3eNxHOV2TE2kdl+jN3KU9VNsSAS7J6M1i/rKU=
Message-ID: <d120d5000511070928l734fa938y2fbeb61be427f81a@mail.gmail.com>
Date: Mon, 7 Nov 2005 12:28:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch 0/7] Another input update
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051103042121.394220000.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103042121.394220000.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> Linus,
>
> Please consider pulling from:
>
>        www.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>
> The main change is that now input core refuses to register input
> devices that were not dynamically allocated to prevent an OOPS
> when attaching input interfaces to such devices.
>
> Changelog:
>        Input: convert dmasound_awacs (OSS) to dynamic input allocation
>                (Ian Wienand)
>        Input: locomokbd - convert to dynamic input allocation
>        Input: do not register statically allocated devices
>        Input: fix input device deregistration
>        Input: locomokbd - fix wrong bustype
>        Input: logips2pp - add support for MX3100
>        Input: lkkbd - miscellaneous fixes
>
> Vojtech, please bless the pull.
>

*ping*

--
Dmitry
