Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVBVGDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVBVGDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVBVGDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:03:21 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:19338 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262212AbVBVGDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:03:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gdvvEqHvm8gb/gJnKUgFQO74Zf2cI9u6kruzguWCAnJibTdw+UCfSH93L7jfOsLHxu9MTd0Hj8UXSmK46tXp8dL5kfaMuuqo0Ba4EvwbXb6a9KPv0EXmxc+on4k9v9Qbr95tfWkdlkftW0O4LZYDr41gCtAED0hCKjgq9faYfIU=
Message-ID: <9e4733910502212203671eec73@mail.gmail.com>
Date: Tue, 22 Feb 2005 01:03:17 -0500
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
> On Mon, 2005-02-21 at 23:56 -0500, Alex Deucher wrote:
> I think that the driver is the "chief" here and the one to know what to
> do with the cards it drives. It can detect a non-POSTed card and deal
> with it.

What about the x86 case of VGA devices that run without a driver being
loaded? Do we force people to load an fbdev driver to get the reset?
The BIOS deficiency strategy works for these devices.

-- 
Jon Smirl
jonsmirl@gmail.com
