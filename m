Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280728AbRKGBAu>; Tue, 6 Nov 2001 20:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280731AbRKGBAk>; Tue, 6 Nov 2001 20:00:40 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:5129 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280727AbRKGBAj>; Tue, 6 Nov 2001 20:00:39 -0500
X-Apparently-From: <moby1gnubie@yahoo.com>
Message-ID: <3BE887BB.9010209@yahoo.com>
Date: Tue, 06 Nov 2001 17:00:43 -0800
From: Jason Collins <moby1gnubie@yahoo.com>
Reply-To: moby1gnubie@yahoo.com
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:0.9.5) Gecko/20011015
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New Cerberus (CTCS) test system release
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel hackers,

I'd like to announce a new release (1.3.0pre4) of the Cerberus Test 
Control System, the software and hardware stress test suite originally 
developed by VA Linux Systems and used by some of you to beat up on 
Linux kernels.  Since I've recently participated in a 'cost-synergy' 
[cough] program at VA, I'm currently taking over development of the 
project solo.  Please note my new e-mail address.   Bug reports, 
patches, job offers, etc are welcome.

Of note in the release:

- PPC Linux support.  newburn will launch without modifications on PPC 
and x86 Linux, and behaviour on both platforms is similar.
- devfs support.  The hardware detection routines will traverse the 
symlink mess in devfs and handle everything correctly now.
- Untested LVM support (Derrick Lee/VA).  The burn-in test will by 
default ignore physical devices with LVM partitions, instead choosing to 
test the LVM virtual device.
- A smattering of bugfixes.

Please see the project page for the full release notes and Changelog at 
http://sourceforge.net/projects/va-ctcs. If you want to be notified of 
all project releases, use the Monitor link on that page.  I only post to 
linux-kernel when a major feature set improvement is made.

Thanks,

Jason T. Collins


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

