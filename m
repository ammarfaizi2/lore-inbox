Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUFLVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUFLVuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUFLVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:50:08 -0400
Received: from p213.54.72.94.tisdip.tiscali.de ([213.54.72.94]:59520 "EHLO
	stralsunder-10.homelinux.org") by vger.kernel.org with ESMTP
	id S264929AbUFLVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:49:49 -0400
Date: Sat, 12 Jun 2004 23:49:47 +0200
From: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Frequent system freezes after kernel bug
Message-ID: <20040612214947.GI1733@rocket>
References: <20040612183742.GE1733@rocket> <20040612202023.GA22145@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040612202023.GA22145@taniwha.stupidest.org> (from cw@f00f.org on Sat, Jun 12, 2004 at 22:20:23 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.12 22:20, Chris Wedgwood wrote:
> On Sat, Jun 12, 2004 at 08:37:42PM +0200, Andreas Schmidt wrote:
> 
> > > kernel: EIP:    0010:[iput+44/592]    Tainted: P
> 
> what modules do you have loaded?
>
root@stralsunder-10:~# lsmod
Module                  Size  Used by    Tainted: P
ipt_MASQUERADE          1272   1  (autoclean)
ipt_state                568  10  (autoclean)
ipt_LOG                 3256   1  (autoclean)
iptable_filter          1700   1  (autoclean)
ip_nat_ftp              2800   0  (unused)
iptable_nat            15448   2  [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_irc        2992   0  (unused)
ip_conntrack_ftp        3696   1
ip_conntrack           19272   2  [ipt_MASQUERADE ipt_state ip_nat_ftp  
iptable_nat ip_conntrack_irc ip_conntrack_ftp]
ip_tables              11416   7  [ipt_MASQUERADE ipt_state ipt_LOG  
iptable_filter iptable_nat]
ppp_deflate             2968   0  (autoclean)
zlib_inflate           18532   0  (autoclean) [ppp_deflate]
zlib_deflate           17912   0  (autoclean) [ppp_deflate]
bsd_comp                3992   0  (autoclean)
ppp_synctty             5152   1  (autoclean)
ppp_generic            20192   3  (autoclean) [ppp_deflate bsd_comp  
ppp_synctty]
slhc                    4672   0  (autoclean) [ppp_generic]
serial                 44228   0  (autoclean)
nls_iso8859-1           2844   0  (unused)
dummy                   1056   1
fcdsl                 862816   2
capi                   18304   5
kernelcapi             29828   3  [fcdsl capi]
capiutil               22368   0  [kernelcapi]
capifs                  3532   1  [capi]
8139too                12296   2
mii                     2400   0  [8139too]
crc32                   2848   0  [8139too]
apm                     9344   2
rtc                     6012   0  (autoclean)
root@stralsunder-10:~#
