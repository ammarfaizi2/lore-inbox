Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVBVGFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVBVGFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVBVGFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:05:37 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:50329 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262216AbVBVGFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:05:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kkZG1MXjWAaM0ZSQaK6YvOBTpf0I6Rg3evTrMgL419uVGsWgwLteqPpP8ksivWNPf7XF7c4SfQcJeTFdYKBKUWl1dL4VCQ6+Ualr8Zmuh6BDDfq+SUQOpJPLKkmsrg0pwLxtMkd0ROM7i2Jiy+M7CUSJ1V/ZMwk+508mxKSfDQY=
Message-ID: <9e473391050221220564235858@mail.gmail.com>
Date: Tue, 22 Feb 2005 01:05:31 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <1109049217.5412.79.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 16:13:36 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> What we can/should provide, is a ncie helper to do the job once the
> driver decides to have a go at it. I think userspace is the right
> solution, similar to the firmware loader helpers, as I wrote earlier.
> There are a few issues related on trying to run these before / is
> mounted or during the sleep process, but those are things I plan to work
> on & fix sooner or later. (Which is also why it has to be an
> asynchronous API, so that the helper can call back "later" when the
> helper has been found).

Can a userspace solution solve the problem of cards that need to be
posted when they are coming out of suspend?

-- 
Jon Smirl
jonsmirl@gmail.com
