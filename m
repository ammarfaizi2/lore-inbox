Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbREXH0o>; Thu, 24 May 2001 03:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbREXH0Y>; Thu, 24 May 2001 03:26:24 -0400
Received: from nwcst289.netaddress.usa.net ([204.68.23.34]:43414 "HELO
	nwcst289.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S263392AbREXH0R> convert rfc822-to-8bit; Thu, 24 May 2001 03:26:17 -0400
Message-ID: <20010524072611.29053.qmail@nwcst289.netaddress.usa.net>
Date: 24 May 2001 01:26:11 MDT
From: Rufuss Angor <rufusz@usa.net>
To: linux-kernel@vger.kernel.org
Subject: set_fs(get_ds()) needed in socket operations?
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I came across this while developing a networked file system:





If I do the socket ops using standard kernel functions they block forever. The
solution I found in some old module was to load the FS segment with the value
of DS and then restore it.





Can someone please explain why this is needed? And isn't it architecture
dependent?





Thanx for your patience with a newbie...





Ruf

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
