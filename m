Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSH1TcJ>; Wed, 28 Aug 2002 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSH1TcJ>; Wed, 28 Aug 2002 15:32:09 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:30639 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318930AbSH1TcH>;
	Wed, 28 Aug 2002 15:32:07 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 28 Aug 2002 13:32:40 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828133240.A766@host110.fsmlabs.com>
References: <20020828134600.A19189@brodo.de> <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com> <20020828124839.F5492@host110.fsmlabs.com> <1030562708.7190.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030562708.7190.59.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 28, 2002 at 08:25:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My frustration comes from the fact that my CPU time is being stolen from me
because of bad mechanical and software design.  I'm not even notified of
it.  If there were some way for the OS to over-ride or even be notified of
these events I'd have less of a problem with it.  As it is now, poor
system design is affecting OS design more and more.

} Systems designers are designing on the basis of thermal slowdowns being
} the optimal way to build some systems. Its actually quite reasonable for
} many workloads.
} 
} > micro-code programmer now-a-days.  That situation needs to be improved
} > upon, as well.
} 
} Cpufreq doesn't handle this case yet in the 2.4 code but it already
} includes the needed udelay correction. Not everything CPUfreq has to
} deal with need be user initiated
} 
