Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDJOYi>; Tue, 10 Apr 2001 10:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDJOY2>; Tue, 10 Apr 2001 10:24:28 -0400
Received: from [212.131.144.194] ([212.131.144.194]:35588 "HELO
	oopsolo.aglorioso.com") by vger.kernel.org with SMTP
	id <S131979AbRDJOYV>; Tue, 10 Apr 2001 10:24:21 -0400
Date: Tue, 10 Apr 2001 16:28:45 +0200
From: sama@aglorioso.com
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] FW: proposal for systems that do not require security
Message-ID: <20010410162845.A18276@aglorioso.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11A6@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27525795B28BD311B28D00500481B7601F11A6@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Tue, Apr 10, 2001 at 02:35:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 02:35:52PM +0200, Heusden, Folkert van wrote:
> Hi,
> 
> I have an idea: I have a couple of linux-systems running in a intranet which
> is not connected to do outside world in any way. Since they're only used for
> calculations for which there is no harm if anyone would tamper with them,
> security is not neccessary. The only thing important, is performance. Huge
> amounts of data must be transferred inbetween these boxes.
> So, I was wondering: isn't it a nice idea to have a switch in the
> configuration menu to disable entropy-gathering in the interrupt-routines,
> have some simplistic routine (like x'=(x * m + a) % p) which returns a non-
> cryptographic value, and something similar symplistic for the network-
> traffic routines?

Have you  already  tried  to  measure  how  much  impact has   entropy
gathering on the overall performances?  Something like the Linux Trace
Toolkit (http://www.opersys.com/LTT/) could be of help here.

I doubt  such optimization  is useful to  the mainstream  kernel tree,
but it would be interesting to compare numbers nonetheless.

Ciao,

Andrea Glorioso
