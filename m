Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272749AbRILLSC>; Wed, 12 Sep 2001 07:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272758AbRILLRv>; Wed, 12 Sep 2001 07:17:51 -0400
Received: from t2.redhat.com ([199.183.24.243]:64249 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272755AbRILLRm>; Wed, 12 Sep 2001 07:17:42 -0400
Message-ID: <3B9F4467.237097F1@redhat.com>
Date: Wed, 12 Sep 2001 12:17:59 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6.4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug still on 2.4.10?
In-Reply-To: <00d301c13b79$56982e20$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> This is on 2.4.8 but I get the funny feeling this maybe hasn't been fixed
> yet for 2.4.10:
> 
> Sep 11 06:58:08 yeti kernel: md: fsck.ext3(pid 151) used obsolete MD
> ioctl(4717), upgrade your software to use new ictls.
> I'm runing:
> Parallelizing fsck version 1.23 (15-Aug-2001)
> Unless maybe I just need to recompile it???

Upgrade to 1.24 or downgrade to 1.22; 1.23 uses the wrong ioctl for some
operations....
