Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVAFS6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVAFS6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVAFS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:57:41 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3855 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262974AbVAFS5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:57:24 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: grendel@caudium.net, linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Date: Thu, 6 Jan 2005 20:56:14 +0200
User-Agent: KMail/1.5.4
References: <20050104195636.GA23034@beowulf.thanes.org>
In-Reply-To: <20050104195636.GA23034@beowulf.thanes.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501062056.14312.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 January 2005 21:56, Marek Habersack wrote:
> equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel config
> is attached.

It isn't...

> The machines have normal load averages hovering not higher than
> 7.0, depending on the time of the day etc. Two of the machines run 2.4.25,
> one 2.4.27 and they work fine. When booted with 2.4.28, though (compiled
> with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config), the load
> is climbing very fast and hovers around a value 3-4 times higher than with
> the older kernels. Booted back in the old kernel, the load comes to its
> usual level. The logs suggest nothing, no errors, nothing unusual is
> happening. 

You may try each of 2.4.28-pre{1,2,3} kernels with identical .config
and pinpoint when did it happen.
--
vda

