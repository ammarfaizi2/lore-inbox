Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSAIJ3L>; Wed, 9 Jan 2002 04:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSAIJ3C>; Wed, 9 Jan 2002 04:29:02 -0500
Received: from earth.cs.mu.OZ.AU ([128.250.37.146]:26888 "EHLO
	earth.cs.mu.oz.au") by vger.kernel.org with ESMTP
	id <S289298AbSAIJ2q>; Wed, 9 Jan 2002 04:28:46 -0500
Date: Wed, 9 Jan 2002 20:28:21 +1100
From: Fergus Henderson <fjh@cs.mu.oz.au>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020109092821.GC18408@earth.cs.mu.oz.au>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000> <15412.14140.652362.747279@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15412.14140.652362.747279@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Jan-2002, Paul Mackerras <paulus@samba.org> wrote:
> "Conforming" means that the program will run the same on any architecture

In ANSI/ISO C and C++, "strictly conforming" means basically what you said.

But "conforming" means much less -- a "conforming program" is just a
program that is acceptable to at least one conforming C implementation
somewhere.  Since conforming C implementations are allowed to accept
*anything*, provided they issue a diagnostic, the term "conforming program"
is essentially meaningless.

-- 
Fergus Henderson <fjh@cs.mu.oz.au>  |  "I have always known that the pursuit
The University of Melbourne         |  of excellence is a lethal habit"
WWW: <http://www.cs.mu.oz.au/~fjh>  |     -- the last words of T. S. Garp.
