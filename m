Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTIDCom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTIDCol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:44:41 -0400
Received: from miranda.zianet.com ([216.234.192.169]:32530 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264553AbTIDCmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:42:07 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Daniel Phillips <phillips@arcor.de>, Antonio Vargas <wind@cocodriloo.com>,
       Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030904023501.GE4306@holomorphy.com>
References: <20030903040327.GA10257@work.bitmover.com>
	 <20030903124716.GE2359@wind.cocodriloo.com>
	 <1062603063.1723.91.camel@spc9.esa.lanl.gov>
	 <200309040350.31949.phillips@arcor.de> <1062641965.3483.78.camel@spc>
	 <20030904023501.GE4306@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062643242.3483.85.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 20:40:43 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 20:35, William Lee Irwin III wrote:
> On Wed, Sep 03, 2003 at 08:19:26PM -0600, Steven Cole wrote:
> > I would never call the SMP locking pathetic, but it could be improved.
> > Looking at Figure 6 (Star-CD, 1-64 processors on Altix) and Figure 7
> > (Gaussian 1-32 processors on Altix) on page 13 of "Linux Scalability for
> > Large NUMA Systems", available for download here:
> > http://archive.linuxsymposium.org/ols2003/Proceedings/
> > it appears that for those applications, the curves begin to flatten
> > rather alarmingly.  This may have little to do with locking overhead.
> 
> Those numbers are 2.4.x

Yes, I saw that.  It would be interesting to see results for recent
2.6.0-textX kernels.  Judging from other recent numbers out of osdl, the
results for 2.6 should be quite a bit better.  But won't the curves
still begin to flatten, but at a higher CPU count?  Or has the miracle
goodness of RCU pushed those limits to insanely high numbers?

Steven

