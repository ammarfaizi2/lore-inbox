Return-Path: <linux-kernel-owner+w=401wt.eu-S1760231AbWLJEdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760231AbWLJEdD (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 23:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760232AbWLJEdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 23:33:03 -0500
Received: from web57809.mail.re3.yahoo.com ([68.142.236.87]:30243 "HELO
	web57809.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760231AbWLJEdB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 23:33:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cImXXD4TY7JRygw5QJUMsOMC6REsdFGO+SocFsaLJlR+5XjTf6ymWhWuHq58Q0ZomFrMctsDF76eY7UDTzR5X7DFjkMw4UDFFL4CQrfWpAna03I8VPdqKE8p/JzNOZ7WiPLW0N9y9BZw4ooR/c/Sz/0kSNt/VPH2A4Xtp4C2LI8=  ;
Message-ID: <20061210043301.30299.qmail@web57809.mail.re3.yahoo.com>
Date: Sat, 9 Dec 2006 20:33:01 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: caglar@pardus.org.tr
Cc: Ismail Donmez <ismail@pardus.org.tr>, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-3
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well yeah, same here. In your case HAL/ KDE was trying to access the VCD. In my case, I was trying to access the VCD by mounting it. 

Had the error been one on Fedora/ openSUSE or distros like that, I would have blamed it on the desktop side. But in Slackware, I wasn't running KDE, and it doesn't even have GNOME or HAL -- so how then can it be one of those? I was trying to do a simple mount of the VCD (as I've always done over these years, to copy the .dat movie files across) -- and that itself failed! 

----- Original Message ----
From: S.Ça»lar Onur <caglar@pardus.org.tr>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: Ismail Donmez <ismail@pardus.org.tr>; Alan <alan@lxorguk.ukuu.org.uk>; linux-kernel@vger.kernel.org
Sent: Sunday, December 10, 2006 3:19:14 AM
Subject: Re: VCD not readable under 2.6.18

But i cannot reproduce the problem that way, in my case dmesg flooded as soon 
as somebody trying to _access_ to VCD. I disabled hal and closed KDE to test 
and that problem no longer reproducible for me. So its really seems a 
userspace problem and i think all of them (KDE's cdpolling backend, hal, 
mplayer and xine-lib) has problems with kernels >= 2.6.17 

-- 
S.Ça»lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in house!




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
