Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbRABW2v>; Tue, 2 Jan 2001 17:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbRABW2l>; Tue, 2 Jan 2001 17:28:41 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:50446 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130007AbRABW2a>; Tue, 2 Jan 2001 17:28:30 -0500
Date: Tue, 2 Jan 2001 22:57:55 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coppermine is a PIII or a Celeron? WINCHIP2/WINCHIP3D diff?
Message-ID: <20010102225755.E888@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>; from cate@dplanet.ch on Tue, Jan 02, 2001 at 08:46:26PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 08:46:26PM +0100, Giacomo A. Catenazzi wrote:
> When working in cpu autoconfiguration I found some problems:
> 
> I have to identify this processor:
>   Vendor: Intel
>   Family: 6
>   Model:  8
> Is it a "Pentium III (Coppermine)" (setup.c:1709)
> or a "Celeron (Coppermine)" (setup.c:1650) ?

Celeron (Coppermine). Here is the output from /proc/cpuinfo on my
laptop:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 1
cpu MHz		: 501.140
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
