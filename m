Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRDWM0C>; Mon, 23 Apr 2001 08:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133009AbRDWMZw>; Mon, 23 Apr 2001 08:25:52 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:43279 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S133006AbRDWMZm>; Mon, 23 Apr 2001 08:25:42 -0400
Date: Mon, 23 Apr 2001 14:19:46 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Xiong Zhao <xz@gatekeeper.ncic.ac.cn>
Cc: majordomo linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: how does linux support domino?
Message-ID: <20010423141945.G2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <77457B80127E.AAA4AA2@gatekeeper.ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <77457B80127E.AAA4AA2@gatekeeper.ncic.ac.cn>; from xz@gatekeeper.ncic.ac.cn on Mon, Apr 23, 2001 at 01:59:52PM +0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 01:59:52PM +0800, Xiong Zhao wrote:
> hello.on linux we will see a new domino server process/thread is
> created for each client.how does linux do this?does it use
> pthread?using fork or clone or someway else?

pthreads are modeled on top of the clone() system call.

> what's the common way of
> linux to support apps like lotus domino that will have lots of
> concurrent users which are served by seperate server process/thread?

Just go ahead and support it, I guess.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
