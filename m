Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVHERNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVHERNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVHERND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:13:03 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:3791 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262447AbVHERKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:10:16 -0400
Date: Fri, 5 Aug 2005 13:10:12 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Antoine Martin <antoine@nagafix.co.uk>
cc: linux-kernel@vger.kernel.org, "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: preempt with selinux NULL pointer dereference
In-Reply-To: <1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
Message-ID: <Pine.LNX.4.63.0508051309360.1149@excalibur.intercode>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal> 
 <Pine.LNX.4.63.0508051024100.559@excalibur.intercode>
 <1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Antoine Martin wrote:

> # cat /proc/sys/kernel/tainted
> 16
> Even figuring out the definition of the 'tainted' masks took a bit of
> googling.

Try something like:

   cat /proc/modules | cut -f1 -d ' '| xargs modinfo


-- 
James Morris
<jmorris@namei.org>
