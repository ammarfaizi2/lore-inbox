Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSAQIaF>; Thu, 17 Jan 2002 03:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSAQI3z>; Thu, 17 Jan 2002 03:29:55 -0500
Received: from oss.sgi.com ([216.32.174.27]:21723 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S288302AbSAQI3n>;
	Thu, 17 Jan 2002 03:29:43 -0500
Date: Thu, 17 Jan 2002 00:29:38 -0800
From: Ralf Baechle <ralf@conectiva.com.br>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: Barry Wu <wqb123@yahoo.com>,
        Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how many cpus can linux support for SMP?
Message-ID: <20020117002938.A2245@dea.linux-mips.net>
In-Reply-To: <20020117065841Z288225-13996+7386@vger.kernel.org> <1011252982.5188.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1011252982.5188.5.camel@localhost.localdomain>; from Thomas.Duffy.99@alumni.brown.edu on Wed, Jan 16, 2002 at 11:36:19PM -0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 11:36:19PM -0800, Thomas Duffy wrote:

> > I am new to this mail list. I do not know how many CPUs linux can
> > support well using SMP. If some one knows, please give me
> > a reply. Thanks.
> 
> there is a 32bit cpu mask, meaning 32 is the absolute max, although Ralf
> Baechle has extended it to 64 in order to support SGI origin 2000's, but
> realistically, linux can only do about 8 before falling on the ground...

Actually Kanoj and me hacked it to work with 128.  The scalability was
already frightening with 32 and even more so with 128 ...

> depends on your workload really...you should be ok with 4 cpus.

Around 4 procs is certainly the sweet spot currently.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
