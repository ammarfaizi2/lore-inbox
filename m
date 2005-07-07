Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVGGTyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVGGTyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVGGTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:52:29 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:7149 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVGGTu6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:50:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QrKk9VsmWXFuEnHalJZT/kspREspM0lJmZdXMX1V5W/Rt2jg9HooR9KVSSts2XyzlVX7nDU2bPsJxJ/z5Ufwm7zsfEHzNnT0CAOFmxWoqmRYYnYrTU1+mZGeYCTn+1lFFl+RMWOthSLbnYF2sQ/dFiFNT5lXhyk48jN4FD8tcSw=
Message-ID: <516d7fa805070712506ab2094b@mail.gmail.com>
Date: Thu, 7 Jul 2005 19:50:54 +0000
From: Mike Richards <mrmikerich@gmail.com>
Reply-To: Mike Richards <mrmikerich@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Swap partition vs swap file
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050628220334.66da4656.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <516d7fa80506281757188b2fda@mail.gmail.com>
	 <20050628220334.66da4656.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Given this situation, is there any significant performance or
> >  stability advantage to using a swap partition instead of a swap file?
> 
> In 2.6 they have the same reliability and they will have the same
> performance unless the swapfile is badly fragmented.

Thanks for the reply -- that's been bugging me for a while now. There
are a lot of different opinions on the net, and most of the
conventional wisdom says use a partition instead of a file. It's nice
to hear from an expert on the matter.

Three more short questions if you have time:

1. You specify kernel 2.6 -- What about kernel 2.4? How less reliable
or worse performing is a swapfile on 2.4?

2. Is it possible for the swapfile to become fragmented over time, or
does it just keep using the same blocks over and over? i.e. if it's
all contiguous when you first create the swapfile, will it stay that
way for the life of the file?

3. Does creating the swapfile on a journaled filesystem (e.g. ext3 or
reiser) incur a significant performance hit?

Thanks again. It's much appreciated.
