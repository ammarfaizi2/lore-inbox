Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbRFRXT1>; Mon, 18 Jun 2001 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbRFRXTR>; Mon, 18 Jun 2001 19:19:17 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:55306 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263409AbRFRXTF>; Mon, 18 Jun 2001 19:19:05 -0400
Date: Tue, 19 Jun 2001 01:18:41 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: gnu asm help...
Message-ID: <20010619011841.C26695@arthur.ubicom.tudelft.nl>
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2068@orsmsx42.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2068@orsmsx42.jf.intel.com>; from ashok.raj@intel.com on Mon, Jun 18, 2001 at 03:56:50PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 03:56:50PM -0700, Raj, Ashok wrote:
> i can understand what the LOCK "incl %0 means.. but not sure what the rest
> is for.
> 
> thanks
> ashokr
> 
> static __inline__ void atomic_inc(atomic_t *v)
> {
>     __asm__ __volatile__(
>         LOCK "incl %0"
>         :"=m" (v->counter)
>         :"m" (v->counter));
> }

I also don't know the exact meaning, but here are two nice tutorials
about inline assembly:

http://www-106.ibm.com/developerworks/linux/library/l-ia.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/9804.2/0953.html



Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
