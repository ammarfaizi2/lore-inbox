Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQL2NeE>; Fri, 29 Dec 2000 08:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbQL2Ndy>; Fri, 29 Dec 2000 08:33:54 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:23045 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129707AbQL2Ndp>; Fri, 29 Dec 2000 08:33:45 -0500
Date: Fri, 29 Dec 2000 13:55:00 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Gregory Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DOS vm86 not working?
Message-ID: <20001229135500.M22081@arthur.ubicom.tudelft.nl>
In-Reply-To: <87u27prmdq.fsf@localhost.freelotto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87u27prmdq.fsf@localhost.freelotto.com>; from gsstark@mit.edu on Thu, Dec 28, 2000 at 03:16:49AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 03:16:49AM -0500, Gregory Stark wrote:
> I just tried dosemu again after upgrading to 2.4.0pre11, and it ran my program
> about halfway and then started spinning with strace reporting:
> 
> vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)
> vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)
> vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)
> 
> I don't see any reason in the source why vm86 would report ENOSYS except if
> the system call simply wasn't present. I'm not really familiar with this
> source though so I could be missing something. Is there something wrong with
> the vm86 code and it's just always returning ENOSYS now?
> 
> I haven't tried this program in 2.2 yet, I'll have to do that next time I get
> a chance to reboot.

What version of dosemu are you using? When running the latest kernel
releases you really need a development version of dosemu. I didn't have
any problem running dosesemu-1.1.1 on 2.4.0-test11. Check out
http://www.dosemu.org/ for the latest release.


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
