Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSGBQaC>; Tue, 2 Jul 2002 12:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSGBQaB>; Tue, 2 Jul 2002 12:30:01 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:42710 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316821AbSGBQaB>;
	Tue, 2 Jul 2002 12:30:01 -0400
Date: Tue, 2 Jul 2002 13:36:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020702133658.I2295@almesberger.net>
References: <3D212757.5040709@quark.didntduck.org> <32193.1025585595@kao2.melbourne.sgi.com> <20020702024322.F2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702024322.F2295@almesberger.net>; from wa@almesberger.net on Tue, Jul 02, 2002 at 02:43:22AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> It's not really just the module information. If I can, say, get
> callbacks from something even after I unregister, I may well
> have destroyed the data I need to process the callbacks, and
> oops or worse.

Actually, if module exit synchronizes properly, even the
return-after-removal case shouldn't exist, because we'd simply
wait for this call to return.

Hmm, interesting. Did I just make the whole problem go away,
or is travel fatigue playing tricks on my brain ? :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
