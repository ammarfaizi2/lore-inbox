Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUDVWir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUDVWir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbUDVWir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:38:47 -0400
Received: from ozlabs.org ([203.10.76.45]:21164 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264270AbUDVWhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:37:00 -0400
Date: Fri, 23 Apr 2004 08:33:46 +1000
From: Anton Blanchard <anton@samba.org>
To: Nick Popoff <cryptic-lkml@bloodletting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing Dual Ethernet via Loopback
Message-ID: <20040422223346.GH22027@krispykreme>
References: <200404190614.21764.cryptic-lkml@bloodletting.com> <20040420192637.GD1413@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420192637.GD1413@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> So what I'm wondering is if there is a way to force Linux to actually
> utilize its network hardware in sending these packets to itself?  In other
> words, a ping or file transfer from an IP assigned to eth0 to another IP
> assigned to eth1 should fail if I unplug the network cable connecting the
> two.  Any advice on this would be much appreciated.  I'm not afraid of
> reading kernel source but have no idea where to start on this one.

Sounds like you need the send-to-self patch:

http://www.ssi.bg/~ja/

We've been using it a lot in the lab, it works well.

Anton
