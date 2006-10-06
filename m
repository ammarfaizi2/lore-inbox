Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWJFMaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWJFMaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWJFMaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:30:21 -0400
Received: from main.gmane.org ([80.91.229.2]:27525 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751284AbWJFMaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:30:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
Date: 06 Oct 2006 14:24:11 +0200
Message-ID: <87zmc9k4yc.fsf@willow.rfc1149.net>
References: <20061006093402.GA12460@zlug.org> <87d595lln3.fsf@willow.rfc1149.net> <20061006120917.GC12460@zlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joerg" == Joerg Roedel <joro-lkml@zlug.org> writes:

Joerg> It is enabled per default because the users get this per
Joerg> default when using the current IPv6 module. James Morris
Joerg> mentioned this issue yesterday. I think setting the default to
Joerg> N would be more consistent, but the Y is probably less painfull
Joerg> for the users.

Makes sense. I proposed this because I reconfigure my kernel with
"make oldconfig" and see new questions pop up. Maybe menuconfig and
xconfig should proeminently highlight NEW questions from the top-level
(by using a bold font on any item which is either new or has new
sub-items) so that users get a clear view of what they may need to
configure.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

