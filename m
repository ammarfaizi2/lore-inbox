Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVAOFOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVAOFOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVAOFOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:14:42 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:38083 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262200AbVAOFOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:14:40 -0500
Date: Sat, 15 Jan 2005 07:14:38 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usb key oddities with 2.6.10-ac9
Message-ID: <20050115051438.GC8456@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050115031532.DAA6F1DC100@bromo.msbb.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115031532.DAA6F1DC100@bromo.msbb.uc.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 10:15:32PM -0500, Jack Howarth wrote:
> Alan,
>     I don't see any changes in how Fedora's 2.6.10 kernels are built 
> that should effect USB hotplugging. The previous kernel I was using
> shows...
...
> ps Fedora did switch with 2.6.10 from using usbdevfs to using usbfs
> but they modified their initscripts package to handle that change.

what about this initscripts change 8.01 --> 8.03?

-       sysctl -w kernel.hotplug="/sbin/hotplug" >/dev/null 2>&1
+       sysctl -w kernel.hotplug="/sbin/udevsend" >/dev/null 2>&1

-- 
