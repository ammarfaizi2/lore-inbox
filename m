Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLWWBk>; Sat, 23 Dec 2000 17:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLWWBa>; Sat, 23 Dec 2000 17:01:30 -0500
Received: from tango.SoftHome.net ([204.144.231.49]:34710 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S129408AbQLWWBQ>; Sat, 23 Dec 2000 17:01:16 -0500
Message-ID: <3A45192F.8C149F93@softhome.net>
Date: Sat, 23 Dec 2000 16:29:19 -0500
From: "Todd M. Roy" <toddroy@softhome.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: lvm 0.8 to 0.9 conversion?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,
   One of my two volume groups, unfortunately the one with
/usr, /var, /opt, and /home, isn't recognized by 0.9's vgscan when
I reboot under 2.4.0-test13-pre4.    But since the second volume
group is visible, and you just told meit should be, then I can just
copy volumes over under test13-pre3 and destroy and recreate the
first volume group.

Thanks,

-- todd --

On Sat, Dec 23, 2000 at 02:24:39PM -0500, Todd M. Roy wrote:
>
>> Now that in 2.4.0-test12-pre4, lvm 0.9 has replaced 0.8, is it
possible
>> to do a conversion of lvm created physical volumes, volume groups
>> and logical volumes from 0.8 to 0.9?
>on-disk format isn't changed so no conversion is needed. You only
>need to upgrade the lvm tools to use the new kernel driver, grab the
tools from
www.sistina.com.

Andre

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
