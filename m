Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTKNU4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTKNU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:56:11 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:32392 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262410AbTKNU4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:56:08 -0500
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl> <3FAE9026.60500@stesmi.com>
	<m3ekwd8w2m.fsf@defiant.pm.waw.pl> <3FB25A28.1070800@stesmi.com>
	<m3oevh7cnu.fsf@defiant.pm.waw.pl> <3FB333B2.2090006@stesmi.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 13 Nov 2003 20:55:37 +0100
In-Reply-To: <3FB333B2.2090006@stesmi.com>
Message-ID: <m3wua411s6.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski <stesmi@stesmi.com> writes:

> x.y.z+1 pre/rc q does not contain
> something that x.y.z pre/rc r has is NOT easy. We both know that
> me and you will have no problem whatsoever with this scheme. So it's
> not about me and you. I just think it will confuse some people that's
> all.

That's correct. It seems I have misunderstood your previous email.

This scheme aims for less workload on the maintainers (compared to
different test + stable trees, as with many popular projects) -
the added bit of complexity at least seems to scale well.

Users already have to live with 2.5.1 being a little older than 2.4.22.

testing/* patches are IMHO not for people who may have problems (bigger
than just a moment of confusion) with such things - they will have much
more problems reporting a bug should they found one.

I know this isn't an ideal solution, that's the best I'm currently aware
of: we'd gain much shorter devel cycle at a really small cost.
I agree entirely with Alan and his opinion expressed in this thread.
-- 
Krzysztof Halasa, B*FH
