Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUJ3R6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUJ3R6y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUJ3R6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:58:53 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:19890 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261233AbUJ3R5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:57:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lK8eH2nzapA6mSbY37qT5H4Pc9WpUsN6IpwrL8EkwtfPSYONoLH2fBSktMfJRa72YEe2MSRnu1xOjoVn6A+1kUvgXy6Q+K7NBk3Zuwz+cOUKG6MBXhiU9YeUU2yBZGS714CTSxVOfPfoczo1LvQcEkXR1XC88630OeOgJh5EwvQ=
Message-ID: <9e473391041030105742477056@mail.gmail.com>
Date: Sat, 30 Oct 2004 13:57:47 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alexander Stohr <alexander.stohr@gmx.de>
Subject: Re: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?]
Cc: airlied@gmail.com, kendallb@scitechsoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <001b01c4bea0$492dce40$8511050a@alexs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1098806794.6000.7.camel@tara.firmix.at>
	 <015101c4bde1$1051bce0$8511050a@alexs>
	 <9e47339104102916141019bd23@mail.gmail.com>
	 <001b01c4bea0$492dce40$8511050a@alexs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ways to protect hardware innovations, trade secrets and
patents. Patents are fully published and trade secrets are not.  Trade
secrets are not a very good way to protect things since once they leak
they are gone. So if you have any good ideas get a patent on them, it
is a much stronger protection and it grants you a legal monopoly.

But patents are all published. So it makes no sense to hide things
that are patented, you can always just read the patents and find out
all of the details.

I don't see any other reason for keeping the programming model secret
other than fear of infringement suits. Many pieces of hardware have
their specs published and they aren't being sued. Why would ATI fare
any differently? I have the R200 specs, there is nothing in there that
hasn't already been done on dozens of other cards.

Why don't you publish the R200 specs on your website, it is older and
interest in it is rapidly falling. I'll bet nothing earth shattering
happens from publishing the spec except that a bunch of open source
developers stop pestering your development support group. You would
also get a lot of goodwill from the press announcement.

I also don't see how you conclude publishing programming specs makes
you a welfare organization. I still have to buy a card to use it. Open
specs will most likely increase your sales not lower them.

I'll keep working on building a base for X on GL. Right now I'm
working on integrating fbdev/DRM into something more coherent. The
basic idea is to bring up a standalone OpenGL with a few added things
like mode setting and cursor support. X will then run on top of that
using only the OpenGL API plus a few extensions for modes and cursors.
Hopefully you'll use my code to build proprietary drivers that support
the newer ATI cards in this model.

-- 
Jon Smirl
jonsmirl@gmail.com
