Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRGCJbs>; Tue, 3 Jul 2001 05:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbRGCJbi>; Tue, 3 Jul 2001 05:31:38 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:40464 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265659AbRGCJbe>; Tue, 3 Jul 2001 05:31:34 -0400
Date: Tue, 3 Jul 2001 11:29:58 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Blesson Paul <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Re: shared memory problem
Message-ID: <20010703112958.L639@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010703084924.4981.qmail@nwcst314.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703084924.4981.qmail@nwcst314.netaddress.usa.net>; from blessonpaul@usa.net on Tue, Jul 03, 2001 at 02:49:24AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 02:49:24AM -0600, Blesson Paul wrote:
>                      I have some confusion regarding key in shmget(). Let I
> have two shared memory variables. For the first one, I put key "99" and the
> size is 1024. Next, I put key "199" for the second variable  and size 1024.
> Will the two shared memory area overwrite each other. How can I gurranty. Is
> the Linux kernel    or the developer who should care about this problem

No, the segments will not overwrite each other, see man shmget and get
"Advanced programming in the UNIX environment" by Richard Stevens.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
