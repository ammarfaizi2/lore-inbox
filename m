Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135680AbRDXPny>; Tue, 24 Apr 2001 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135684AbRDXPno>; Tue, 24 Apr 2001 11:43:44 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:45640 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135680AbRDXPnj>; Tue, 24 Apr 2001 11:43:39 -0400
Message-ID: <3AE59E80.810D922@redhat.com>
Date: Tue, 24 Apr 2001 11:40:48 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Kuznetsov <divx@euro.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with i810_audio driver
In-Reply-To: <921508308.20010421012021@euro.ru> <3AE4EAEB.254B2A48@redhat.com> <92987369.20010424060258@euro.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Kuznetsov wrote:

>  The whole thing sounds to my mind as having some kind of resource,
> register, etc. which is supposed to be initialized during loading of
> drivers, but it's not done by i810_audio driver.

Sounds that way to me too.  I didn't write that portion of the code, so it
will take me a little bit to figure out where it is screwing up at.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
