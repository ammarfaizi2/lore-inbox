Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291992AbSBNXzL>; Thu, 14 Feb 2002 18:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291994AbSBNXzB>; Thu, 14 Feb 2002 18:55:01 -0500
Received: from zero.tech9.net ([209.61.188.187]:25352 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291992AbSBNXyp>;
	Thu, 14 Feb 2002 18:54:45 -0500
Subject: Re: tux officially in kernel?
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@lexus.com>
Cc: john slee <indigoid@higherplane.net>, J Sloan <joe@tmsusa.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C6C4942.4050305@lexus.com>
In-Reply-To: <Pine.LNX.4.30.0202111313100.28040-100000@mustard.heime.net>
	<3C67F327.8010404@tmsusa.com> <20020213135841.GB4826@higherplane.net> 
	<3C6C4942.4050305@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 18:54:41 -0500
Message-Id: <1013730883.807.251.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-14 at 18:33, J Sloan wrote:

> So, just out of curioisity, why is khttpd in
> the kernel? If there were any web server
> in the mainline kernel I'd think it'd be tux -

Personally khttpd should be ripped from the kernel.  It is a nice, uh,
example.  Or something.

TUX touches enough code that it isn't a clear decision to merge,
although it is certainly worth it.  I, however, think we are rapidly
approaching the point, if not there already, that with a zero-copy
network driver userspace can perform as good as TUX with none of the
downsides.  That was part of Ingo's goal and a lot of the benefits -
sendfile etc - are a result of TUX.

Anyhow, if I recall correctly, X15 performed better than TUX.

	Robert Love

