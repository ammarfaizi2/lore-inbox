Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313683AbSDHQGb>; Mon, 8 Apr 2002 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313688AbSDHQGa>; Mon, 8 Apr 2002 12:06:30 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.147]:25333 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S313683AbSDHQG1>; Mon, 8 Apr 2002 12:06:27 -0400
X-Biglobe-Sender: <miyazawa@mrj.biglobe.ne.jp>
Date: Tue, 9 Apr 2002 01:06:20 +0900
From: Kazunori Miyazawa <miyazawa@mrj.biglobe.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: USAGI Core <usagi-core@linux-ipv6.org>
Subject: USAGI stable release
Message-Id: <20020409010620.77548c28.miyazawa@mrj.biglobe.ne.jp>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are glad to announce the USAGI[1] STABLE RELEASE 3.1, dated on April 8th,
2002.  Although this is a maintenance release of the STABLE RELEASE 3 dated 
on January 1st, 2002, it comes with a latest kernel and couple of new 
features.  

The new / updated features are:
	- based on latest kernel linux-2.4.18 
	  (linux-2.2.20 for linux-2.2 systems)
	- based on radvd-0.7.1, a router advertisement daemon
	- ISATAP (Intra-Site Automatic Tunnel Addressing Protocol) support
	- IPv4 and/or IPv6 over IPv4 Tunnel on a single driver support
	- Privacy Extensions for linux-2.2 systems

We also fixed the following bugs of the previous release:
	- Fixed a bug, which devices, such as PCMCIA devices, could not
	  finish correctly when using Privacy Extensions.
	- Fixed a bug, which getifaddrs(3) did not report local/remote 
	  addresses of point-to-point devices.
	- Fixed a bug, which tcp_wrapper was not compiled correctly,
	  so that ipv6 support was not enabled.
	and so on.

You can get our complete kit which includes kernel tree, library and 
applications from the following URL.
	<ftp://ftp.linux-ipv6.org/pub/usagi/stable/kit/>

We also provide separate patches against the main-line kernel and the tools.
	<ftp://ftp.linux-ipv6.org/pub/usagi/stable/split/>

We have a plan to provide the binary packages for some distributions.
They will appear under
	<ftp://ftp.linux-ipv6.org/pub/usagi/stable/packages/>
within several weeks.


We announce the latest information on our web pages.  
Please check our web site <http://www.linux-ipv6.org>.

We also manage the mailing list for USAGI users. 
If you have questions, please join the mailing list.
Comments and advises are also welcome on that mailing list.  
Please visit <http://www.linux-ipv6.org/ml/> for further
information.


Thanks.


About USAGI Project:

The USAGI Project is managed by volunteers and aims to provide better
IPv6 environment on Linux freely.  We are tightly collaborating with
WIDE Project[2], KAME Project[3] and TAHI Project[4], and trying to
improve Linux kernel, IPv6 related libraries and IPv6 applications.
Our snapshots are released every two weeks and stable release is
released several times a year.  Please check our web site
<http://www.linux-ipv6.org> for the latest information.


In-Reply-To:

	[1] USAGI Project       <http://www.linux-ipv6.org>
	[2] WIDE Project        <http://www.wide.ad.jp>
	[3] KAME Project        <http://www.kame.net>
	[4] TAHI Project        <http://www.tahi.org>

-- 
USAGI Project <http://www.linux-ipv6.org>


