Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285318AbRLSPV4>; Wed, 19 Dec 2001 10:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285323AbRLSPVq>; Wed, 19 Dec 2001 10:21:46 -0500
Received: from smtp02.fields.gol.com ([203.216.5.132]:32019 "EHLO
	smtp02.fields.gol.com") by vger.kernel.org with ESMTP
	id <S285322AbRLSPVl>; Wed, 19 Dec 2001 10:21:41 -0500
Date: Thu, 20 Dec 2001 00:21:17 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-Id: <20011220002117.6b660fa0.masaruk@gol.com>
In-Reply-To: <20011219180100.A28971@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
	<20011219230812.049c2c5c.masaruk@gol.com>
	<20011219172644.A28692@namesys.com>
	<20011219235203.322a02e3.masaruk@gol.com>
	<20011219180100.A28971@namesys.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: "3UD?v?v'zSkYncgSd/w8_XIZeI<6UVWiR|O`MK|4r<R13hW),-w;.4EGFl]M=i9H/_&}\1 sKHvNj7@@1vM\{'-2s{Os@$kL9Tv_XHO2:2/DJSC5c\k:|=g{~sn(jc~EDth4,/}3.O0g8X/\5bhi2 ^{gjQFxH`RH{?z"Gqh5Kt^n%/v],ZNO"zO~Re
X-Operating-System: Kondara MNU/Linux 2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >   # cat /proc/fs/reiserfs/*/version
> >   new format      with checks off
> Hm. You said you are running 2.4.17-rc2, this is output from older kernel.
> Or do you mean it is only 2.4.17-rc2 that cannot remount root read-write?

Yes, the cat output was from 2.4.16.  Kernels before -rc1 can remount
this root partition without errors.

> Ok, I still want the metadata from this partition (read man on debugreiserfsck on -p option),
> and tell me you reiserfsutils version.

Ok, I'll try that tomorrow.
(In Japan, it's midnight.  I want to go to sleep now.)

> Also were there any reiserfs specific error messages prior to the oops?

There was no error message from reiserfs.

Thank you.

-- 
Masaru Kawashima <masaruk@gol.com>
