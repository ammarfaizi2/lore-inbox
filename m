Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266046AbRGLHed>; Thu, 12 Jul 2001 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbRGLHeW>; Thu, 12 Jul 2001 03:34:22 -0400
Received: from elin.scali.no ([195.139.250.10]:27660 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266046AbRGLHeE>;
	Thu, 12 Jul 2001 03:34:04 -0400
Message-ID: <3B4D527B.786F7461@scali.no>
Date: Thu, 12 Jul 2001 09:32:11 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Ho Chak Hung <hunghochak@netscape.net>, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages 4 order allocation failed
In-Reply-To: <Pine.LNX.4.33.0107111925250.371-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Wed, 11 Jul 2001, Ho Chak Hung wrote:
> 
> > Hi,
> > but there isn't any call in the module to allocate 4 order pages. There are only calls to allocate 0 order pages. alloc_pages(GFP_KERNEL, 0)is the only call to allocate page in the whole module.
> 
> Then it's not your module :)
> 
> Some driver may be asking for order 4, but settling for less when
> that fails.
> 
Why did this get worse on the 2.4 kernel ?. On 2.2 I always seemed to get my high order
allocations  and GFP_ATOMIC seldom failed when there was available memory.

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
