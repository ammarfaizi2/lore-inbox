Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbREPMZE>; Wed, 16 May 2001 08:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbREPMYy>; Wed, 16 May 2001 08:24:54 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:51730 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261902AbREPMYo>; Wed, 16 May 2001 08:24:44 -0400
Date: Wed, 16 May 2001 14:20:55 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "A Dell'elce" <neaya@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read-only memory on x86?
Message-ID: <20010516142055.F902@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010516121033.91421.qmail@web13305.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010516121033.91421.qmail@web13305.mail.yahoo.com>; from neaya@yahoo.com on Wed, May 16, 2001 at 05:10:33AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 05:10:33AM -0700, A Dell'elce wrote:
> Can I set a memory area or "page" to be read-only, i.e. 
> generate an interrupt when writing is attempted to a certain 
> page/area?

man mmap and catch SIGSEGV. Or see how the DOSemu VGA emulator
manipulates the virtual VGA memory.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
