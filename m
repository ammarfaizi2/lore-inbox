Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271598AbRIBJmk>; Sun, 2 Sep 2001 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271599AbRIBJma>; Sun, 2 Sep 2001 05:42:30 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:10767 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271598AbRIBJmQ>; Sun, 2 Sep 2001 05:42:16 -0400
Date: Sun, 2 Sep 2001 11:42:25 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, Lars Christian Nygaard <lars@snart.com>
Subject: Re: 2.4.6 error
Message-ID: <20010902114225.C697@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.30.0109021117260.2609-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0109021117260.2609-100000@mustard.heime.net>; from roy@karlsbakk.net on Sun, Sep 02, 2001 at 11:26:27AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 11:26:27AM +0200, Roy Sigurd Karlsbakk wrote:
> I just got a whole bunch of the following error on my 2.4.6 installation.
> Virtual address (EIP), pde, pte, eflags, edx, esi, edi, the first quad in
> the stack and the call trace remains stable. The others are varying. The
> oops comes whenever sa1 (in sysstat) is run.
> 
> please cc: to me as I'm not on the list
> 
> roy
> 
> Code:  Bad EIP value.
> Unable to handle kernel paging request at virtual address c9049180
>  printing eip:
> c9049180
> *pde = 07f8b067
> *pte = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c9049180>]
> EFLAGS: 00010282
> eax: c1903f68   ebx: c6c5d960   ecx: c6c5d980   edx: c9049180
> esi: 00000400   edi: 00000000   ebp: c3b7c000   esp: c1903f40
> ds: 0018   es: 0018   ss: 0018
> Process sadc (pid: 9922, stackpage=c1903000)
> Stack: c0149fcd c3b7c000 c1903f68 00000000 00000400 c1903f64 c90500e0 c7f7b8c0
>        00000000 00000000 00000000 c6c5d960 ffffffea 00000000 00000400 c012ea28
>        c6c5d960 40017000 00000400 c6c5d980 00000000 00001000 00000003 00000022
> Call Trace: [<c0149fcd>] [<c012ea28>] [<c0106d43>]

Could you run this through ksymoops and repost to linux-kernel? The
addresses are useless right now. See REPORTING-BUGS and
Documentation/oops-tracing.txt in the linux source tree for details.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
