Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUF2TRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUF2TRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUF2TPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:15:49 -0400
Received: from mx2.magma.ca ([206.191.0.250]:57832 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S265932AbUF2TOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:14:23 -0400
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: Jesse Stockall <stockall@magma.ca>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040629112256.58828632@dell_ss3.pdx.osdl.net>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	 <20040629112256.58828632@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1088536410.8382.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 15:13:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 14:22, Stephen Hemminger wrote:
> 
> Dave enabled the receive buffer auto-tuning which uses TCP window
> scaling.  It looks like all these sites are running FreeBSD, perhaps
> there is a bug in FreeBSD?
> 
> As suggested earlier please get a TCP dump of a failed connection.
> 
> To turn of receive buffer auto-tuning:
> 	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
> 	sysctl -w net.ipv4.tcp_default_win_scale=0
> 

This works around the inaccessible websites, packages.gentoo.org (not a
FreeBSD box) can now be reached.

This however does not resolve the java issue. The application dies when
trying to connect to receive data.

-- 
Jesse Stockall <stockall@magma.ca>

