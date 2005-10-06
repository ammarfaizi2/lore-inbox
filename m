Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVJFNjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVJFNjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVJFNjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:39:15 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:39845 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750893AbVJFNjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:39:15 -0400
Message-ID: <3667.192.168.201.6.1128605949.squirrel@pc300>
Date: Thu, 6 Oct 2005 14:39:09 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Sorry, it has happen again, some software removed the last newline
 of the patches during attachement.
 To rebuild them, just add a newline at end of each file:

$ wget
'http://marc.theaimsgroup.com/?l=linux-kernel&m=112859209607340&q=p3' -O
patch2614rc3-1
$ wget
'http://marc.theaimsgroup.com/?l=linux-kernel&m=112859247823724&q=p3' -O
patch2614rc3-2
$ wget
'http://marc.theaimsgroup.com/?l=linux-kernel&m=112859247807836&q=p3' -O
patch2614rc3-3
$ echo >> patch2614rc3-1
$ echo >> patch2614rc3-2
$ echo >> patch2614rc3-3
$ cd linux-2.6.14-rc3
$ patch -p1 -i ../patch2614rc3-1
$ patch -p1 -i ../patch2614rc3-2
$ patch -p1 -i ../patch2614rc3-3

 Etienne.

