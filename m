Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbREXNf1>; Thu, 24 May 2001 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbREXNfR>; Thu, 24 May 2001 09:35:17 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:34570 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261925AbREXNfM>; Thu, 24 May 2001 09:35:12 -0400
Date: Thu, 24 May 2001 15:20:48 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Message-ID: <20010524152048.D1477@arthur.ubicom.tudelft.nl>
In-Reply-To: <lx4rubc8kq.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <lx4rubc8kq.fsf@pixie.isr.ist.utl.pt>; from yoda@isr.ist.utl.pt on Thu, May 24, 2001 at 12:03:49PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 12:03:49PM +0100, Rodrigo Ventura wrote:
>         I am submitting a patch to kernel/sys.c that walks through all
> IDE drives (#ifdef CONFIG_BLK_DEV_IDE, of course), and issues a
> "sleep" command (as code in hdparam) to each one of them right before
> the kernel halts. Here goes the diff:

What was wrong with "hdparm -Y /dev/hd*" in the halt/reboot script that
you need to do it in kernel?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
