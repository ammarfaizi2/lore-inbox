Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSGJUcx>; Wed, 10 Jul 2002 16:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSGJUcw>; Wed, 10 Jul 2002 16:32:52 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:35025
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S317606AbSGJUcw>; Wed, 10 Jul 2002 16:32:52 -0400
Message-ID: <3D2C9A98.70509@fugmann.dhs.org>
Date: Wed, 10 Jul 2002 22:35:36 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: jamesclv@us.ibm.com
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Chatserver workload simulator by Bill Hartner?
References: <629E717C12A8694A88FAA6BEF9FFCD440540AA@brigadoon.spirentcom.com> <200207101317.39447.jamesclv@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks - You just saved me a couple of hours there.

I've also located a showstopper bug in the chat server code.
If anyone steps forward as the maintainer, I will gladly send a patch.

The bug is when using accept, the last argument should be the size of the 2. argument but
it is zero in the chat server.

Regards
Anders Fugmann

James Cleverdon wrote:
> On Tuesday 09 July 2002 09:35 am, Perches, Joe wrote:
> 
> The chat-1.0.1.tar.gz on that page still has a memory free/use bug with the ti 
> array.  I sent the patch to bhartner, but maybe he's not maintaining it 
> anymore.  It only seems to cause trouble when running heavy loads.  (Maybe 
> large blocks of memory get coalesced, or something.)  Anyway, here it is:
<patch cut out>

