Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSGRAIG>; Wed, 17 Jul 2002 20:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGRAIG>; Wed, 17 Jul 2002 20:08:06 -0400
Received: from p508879A0.dip.t-dialin.net ([80.136.121.160]:60062 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315222AbSGRAIG>; Wed, 17 Jul 2002 20:08:06 -0400
Date: Wed, 17 Jul 2002 18:10:38 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: close return value
In-Reply-To: <200207180001.g6I015f02681@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0207171809200.3452-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 Jul 2002, Pete Zaitcev wrote:
> The problem with errors from close() is that NOTHING SMART can be
> done by the application when it receives it. And application can:
> 
>  a) print a message "Your data are lost, have a nice day\n".
>  b) loop retrying close() until it works.
>  c) do (a) then (b).

(a) is much saner than silently loosing data.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

