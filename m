Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVCPEzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVCPEzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVCPEzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:55:47 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:32716 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262512AbVCPEzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:55:43 -0500
Subject: Re: [PATCH][RFC] /proc umask and gid [was: Make /proc/<pid>
	chmod'able]
From: Albert Cahalan <albert@users.sf.net>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
In-Reply-To: <20050316023923.GA27736@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube>
	 <20050316023923.GA27736@lsrfire.ath.cx>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 23:41:28 -0500
Message-Id: <1110948088.1967.282.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Better interface:

/sbin/sysctl -w proc.maps=0440
/sbin/sysctl -w proc.cmdline=0444
/sbin/sysctl -w proc.status=0444

The /etc/sysctl.conf file can be used to set these
at boot time.


