Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277220AbRJINwF>; Tue, 9 Oct 2001 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277217AbRJINvz>; Tue, 9 Oct 2001 09:51:55 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:11780 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277221AbRJINvp>; Tue, 9 Oct 2001 09:51:45 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15299.155.336692.937712@beta.reiserfs.com>
Date: Tue, 9 Oct 2001 17:50:19 +0400
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [LTP] VFS: brelse: started after 2.4.10-ac7 
In-Reply-To: <20011009094707.B4951@earthlink.net>
In-Reply-To: <20011009094707.B4951@earthlink.net>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net writes:
 > 
 > About 2 minutes into "runalltests.sh" on ltp, ac kernels after 2.4.10-ac7
 > give a message like:

On what file-system ltp runs?

 > 
 > Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer
 > Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer
 > 
 > Repeatability:   Good
 > 
 > Seen on:
 > 
 > 2.4.10-ac8
 > 2.4.10-ac10
 > 2.4.10-ac10+eatcache
 > 
 > Not seen on:
 > 
 > 2.4.10-ac4
 > 2.4.10-ac7
 > 2.4.11-pre2
 > 2.4.11-pre6
 > 
 > Has occurred on every case with ac8 and ac10, and no test before.  
 > 
 > Doesn't happen on Linus kernels.
 > 
 > Does not occur on my laptop, which is ext2 only.
 > 
 > Did not occur on Athlon when /tmp was mounted as ext2.  
 > (LTP tests write a lot of files to /tmp).
 > 
 > 
 > I haven't tracked down which test generates the message yet, but it is
 > before the "personality" tests.
 > 
 > 
 > Configuration
 > -------------
 > 
 > Linux rushmore 2.4.10-ac10a #2 Tue Oct 9 00:42:57 EDT 2001 i686 unknown
 > 
 > Gnu C                  2.95.3
 > Gnu make               3.79.1
 > binutils               2.11.2
 > util-linux             2.11l
 > mount                  2.11l
 > modutils               2.4.10
 > e2fsprogs              1.25
 > reiserfsprogs          3.x.0j
 > PPP                    2.4.1
 > Linux C Library        2.2.4
 > Dynamic linker (ldd)   2.2.4
 > Procps                 2.0.7
 > Net-tools              1.60
 > Kbd                    1.06
 > Sh-utils               2.0
 > Modules Loaded         cmpci ppp_deflate bsd_comp ppp_async ipt_state ipt_limit ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables
 > 
 > 
 > 
 > -- 
 > Randy Hron
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
