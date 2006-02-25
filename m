Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWBZIzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWBZIzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 03:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWBZIzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 03:55:21 -0500
Received: from amazonas-1267.adsl.datanet.hu ([195.56.228.251]:3542 "HELO
	gw.koan19.net") by vger.kernel.org with SMTP id S1751276AbWBZIzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 03:55:21 -0500
Date: Sat, 25 Feb 2006 23:44:54 +0100
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Avi Kivity <avi@argo.co.il>, Victor Porton <porton@ex-code.com>,
       linux-kernel@vger.kernel.org
Subject: Re: New reliability technique
Message-ID: <20060225224454.GA10628@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Avi Kivity <avi@argo.co.il>, Victor Porton <porton@ex-code.com>,
	linux-kernel@vger.kernel.org
References: <E1FCzMX-0000Ym-00@porton.narod.ru> <9a8748490602250526p2187e04ej9a680e6b2b948e7d@mail.gmail.com> <9a8748490602250527l78e057ecvcd2e656b8ff5c9f2@mail.gmail.com> <4400B562.6020203@argo.co.il> <9a8748490602251156y6dc22a7by53b85570feb8d4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602251156y6dc22a7by53b85570feb8d4a7@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>On 2/25/06, Victor Porton <porton@ex-code.com> wrote:
> > >>>A minute ago I invented a new reliability enhancing technique.

> > >>>In idle cycles (or periodically in expense of some performance) Linux can
> > >>>calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
> > >>>sums with previously calculated sums.

On 2006-02-25 at 20:56:27, Jesper Juhl wrote:
> Ohh, ok, then it makes sense as a debug thing.
> 
> Let's see an implementation then.

http://www.ussg.iu.edu/hypermail/linux/kernel/9701.1/0058.html

At least a variation of it, maybe not from a minute ago :)
