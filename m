Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266019AbRF1QVu>; Thu, 28 Jun 2001 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266018AbRF1QVl>; Thu, 28 Jun 2001 12:21:41 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:28681 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266013AbRF1QVc>;
	Thu, 28 Jun 2001 12:21:32 -0400
Date: Thu, 28 Jun 2001 18:21:24 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: John Fremlin <vii@users.sourceforge.net>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <20010628182124.A3728@pcep-jamie.cern.ch>
In-Reply-To: <3B38860D.8E07353D@kegel.com> <m23d8kiwx0.fsf@boreas.yi.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m23d8kiwx0.fsf@boreas.yi.org.>; from vii@users.sourceforge.net on Thu, Jun 28, 2001 at 01:58:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> >        A signal number cannot be opened more than once concurrently;
> >        sigopen() thus provides a way to avoid signal usage clashes
> >        in large programs.
> 
> Signals are a pretty dopey API anyway - so instead of trying to patch
> them up, why not think of something better for AIO?

Keep in mind that SIGRTxxx signals are not just used for AIO.

-- Jamie
