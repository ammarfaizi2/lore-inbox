Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290496AbSBFNQh>; Wed, 6 Feb 2002 08:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSBFNQ2>; Wed, 6 Feb 2002 08:16:28 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:8092 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S290496AbSBFNQT>; Wed, 6 Feb 2002 08:16:19 -0500
Message-ID: <3C612CEC.A3BEB92C@oracle.com>
Date: Wed, 06 Feb 2002 14:17:32 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Patching drivers/char/gameport with /dev/null doesn't work for me. What
> is the trick ?

In my case has been

 - untar 2.5.3 in /usr/src/linux
 - cd linux; ln -s linux a
 - patch
 - cd /usr/src; mv b/drivers/input/* /usr/src/linux/drivers/input
 - build

I only have to reboot and see if it works :)

--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
