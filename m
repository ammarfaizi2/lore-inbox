Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbTCSVIP>; Wed, 19 Mar 2003 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263176AbTCSVIP>; Wed, 19 Mar 2003 16:08:15 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:2053 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S263172AbTCSVIO>;
	Wed, 19 Mar 2003 16:08:14 -0500
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Everything gone!
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>
	<Pine.LNX.4.53.0303191059140.31680@chaos>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.53.0303191059140.31680@chaos>
Date: 19 Mar 2003 16:18:59 -0500
Message-ID: <m3vfyfdph8.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> How did [they] do this?

If you look at the Received headers in the faked message, it actually
came to kernel.org from alog0102.analogic.com, from Analogic's
208.224.220.0/22 netblock, not from quark.analogic.com (in Analogic's
204.178.40.0/21 block) as it claimed:

Received: from alog0102.analogic.com ([208.224.220.117]:12804 "EHLO
	quark.analogic.com") by vger.kernel.org with ESMTP
	id <S263082AbTCSPfa>; Wed, 19 Mar 2003 10:35:30 -0500

If an analogic box was cracked, look at 208.224.220.117, not at quark.

The routing suggests they would not have been able to spoof the IP,
unless they did so over eg an 802.11 link at whatever site
208.224.220.0/22 is used.  

-JimC

