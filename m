Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRIEMQ7>; Wed, 5 Sep 2001 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIEMQt>; Wed, 5 Sep 2001 08:16:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:40696 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272122AbRIEMQj>; Wed, 5 Sep 2001 08:16:39 -0400
Message-ID: <3B9617BA.F771914E@redhat.com>
Date: Wed, 05 Sep 2001 13:16:58 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6.4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAEAPDLAA.davids@webmaster.com> <E15ebSj-0005ig-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > based upon whether you have the source or not. What should logically taint
> > the kernel are modules that weren't compiled for that exact kernel version
> > or are otherwise mismatched.
> 
> Setting a flag for the insmod -f required case as well is an extremely good
> idea. This is entirely about making information available nothing else and
> your suggestion there is a good one.

How about making the "tainted" field a bitmask ?
eg bit 0 --> non GPL/BSD module
   bit 1 --> insmod -f

Greetings,
    Arjan van de Ven
