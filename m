Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUAGNxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUAGNxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:53:37 -0500
Received: from main.gmane.org ([80.91.224.249]:48010 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266209AbUAGNxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:53:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Slow receive with AX8817 USB2 ethernet adapter
Date: Wed, 07 Jan 2004 14:53:33 +0100
Message-ID: <yw1xisjnvp9e.fsf@ford.guide>
References: <yw1xr7ybvpv0.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:HFURBMbVmJbKhfXZEMOgadDu4dA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> I'm getting very bad receive rates with a Netgear FA-120 USB2 Ethernet
> adapter under Linux 2.6.0.  Timing an incoming TCP stream, I get only
> 600 kB/s.  Sending works properly at 10 MB/s.  I first reported this
> problem some time in July or August.  Is it just me having this issue?
> Can I get any helpful information somehow?

I can add that mii-tool reports this:

eth0: negotiated 100baseTx-FD flow-control, link ok
  product info: vendor 00:00:20, model 32 rev 1
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

-- 
Måns Rullgård
mru@kth.se

