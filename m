Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280797AbRKGOJ4>; Wed, 7 Nov 2001 09:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280796AbRKGOJq>; Wed, 7 Nov 2001 09:09:46 -0500
Received: from full215.sara.unitn.it ([193.205.210.215]:50162 "EHLO
	dizzy.dz.net") by vger.kernel.org with ESMTP id <S280800AbRKGOJg>;
	Wed, 7 Nov 2001 09:09:36 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111071242.fA7CgmcY001822@dizzy.dz.net>
Subject: Re: i8kutils
In-Reply-To: <15336.42604.800408.258987@megginson.com> "from David Megginson
 at Nov 6, 2001 10:11:40 pm"
To: David Megginson <david@megginson.com>
Date: Wed, 7 Nov 2001 13:42:48 +0100 (MET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Massimo:
> 
> Great work!  I have one quick question though -- what version of
> setmixer are you using for your default commands?  The one in Debian
> does not allow arguments like "+5".  I haven't found any command-line
> mixer that supports muting yet (aumix mutes only in interactive mode).
> 
> 
> All the best,
> 
> 
> David
> 
> -- 
> David Megginson
> david@megginson.com
> 

I use a small shell script which reads the current volume and changes
it incrementally. As explained in the manpage you should specify your
own commands with the command-line options, for example:

  i8kbuttons -u "aumix -v +10" -d "aumix -v -10" -m "aumix -v 0"

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
