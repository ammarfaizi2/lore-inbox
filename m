Return-Path: <linux-kernel-owner+w=401wt.eu-S1757734AbWLIRXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbWLIRXe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 12:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758267AbWLIRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 12:23:33 -0500
Received: from web57808.mail.re3.yahoo.com ([68.142.236.86]:29684 "HELO
	web57808.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757734AbWLIRXd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 12:23:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s3BLS9/YW+bBYMHAvlET8a09M6j9i8kfRD72RhB1fqWTgzLXRhC6IlTTPA/IdIyBRBWb5jtgjHxn7FfXxf7z15ewLN63ovTYb1/qAHXjnIfxw/2fB5iibK6/6nIFFj+XXmT8tDqYRJ4lkq7xcVPbwQDQroGHnjirRwCL7SQAaXg=  ;
Message-ID: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
Date: Sat, 9 Dec 2006 09:23:32 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: caglar@pardus.org.tr, Ismail Donmez <ismail@pardus.org.tr>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-3
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Infact, just inserting a CD is enough. No need for a media player to try and access the files. :)

The backend must be polling and trying to mount the disc upon insertion. Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't and give error messages. Which explains why downgrading the kernel solves the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't downgrading the kernel *not* help?) Just thinking aloud ... 

----- Original Message ----
From: S.Ça»lar Onur <caglar@pardus.org.tr>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Alan <alan@lxorguk.ukuu.org.uk>; Rakhesh Sasidharan <rakhesh@rakhesh.com>; rakheshster@yahoo.com; linux-kernel@vger.kernel.org
Sent: Saturday, December 9, 2006 8:09:05 PM
Subject: Re: VCD not readable under 2.6.18

09 Ara 2006 Cts 16:15 tarihinde, Ismail Donmez ºunlar¹ yazm¹ºt¹: 
> Well my bet is xine-lib is buggy somehow as I can reproduce this bug with
> kaffeine ( KDE media player ).

Same symptoms occur with mplayer also, dmesg flooded with warnings, what about 
hal or KDE's cdpolling backend?

Cheers
-- 
S.Ça»lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in house!





 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
