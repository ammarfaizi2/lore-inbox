Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbREPMTy>; Wed, 16 May 2001 08:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbREPMTo>; Wed, 16 May 2001 08:19:44 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:8722 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261903AbREPMTd>; Wed, 16 May 2001 08:19:33 -0400
Date: Wed, 16 May 2001 14:18:02 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Jalajadevi Ganapathy <JGanapathy@storage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel2.2 to kernel2.4!!
Message-ID: <20010516141802.E902@arthur.ubicom.tudelft.nl>
In-Reply-To: <OF8E6F662B.FFAB9815-ON85256A4E.00424ECA@storage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF8E6F662B.FFAB9815-ON85256A4E.00424ECA@storage.com>; from JGanapathy@storage.com on Wed, May 16, 2001 at 08:05:01AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 08:05:01AM -0400, Jalajadevi Ganapathy wrote:
> Hi , I encounter an unresolved symbol __bad_udelay when i ported a network
> driver from kernel2.2 to 2.4.
> Could anyone plz tell me what is the corresponding fxn in 2.4??

It means that you're udelay()ing way to long in that driver. So you
basically have to fix your driver.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
