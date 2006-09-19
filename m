Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWISNPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWISNPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWISNPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:15:43 -0400
Received: from main.gmane.org ([80.91.229.2]:49042 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030286AbWISNPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:15:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [RFC-patch 0/3] SuperIO locks coordinator
Date: 19 Sep 2006 15:11:17 +0200
Message-ID: <87k6402e8a.fsf_-_@willow.rfc1149.net>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Cc: lm-sensors@lm-sensors.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jim" == Jim Cromie <jim.cromie@gmail.com> writes:

Jim> The module does *not* guarantee anything, it offers no protection
Jim> against rogue (existing) modules which dont use the superio-locks
Jim> coordinator.  (is anti-rogue protection even possible?  Perhaps,
Jim> IFF modules reserve the 2 superio addresses - semi-rogue?)

I don't think we can prevent bad things from happening if someone
doesn't play the game and uses the device using IO ports directly on a
SMP.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

