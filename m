Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUJVXae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUJVXae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUJVX3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:29:25 -0400
Received: from main.gmane.org ([80.91.229.2]:734 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268455AbUJVX1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:27:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <aripollak@gmail.com>
Subject: Re: udev doesn't add a device for one of my partitions under 2.6.9
Date: Fri, 22 Oct 2004 19:27:28 -0400
Message-ID: <41799760.4090403@gmail.com>
References: <clbgip$63d$1@sea.gmane.org> <20041022230209.GA26748@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
In-Reply-To: <20041022230209.GA26748@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Does /sys/block/hda/ show partition the partition you are missing?  If
> not, there's no way that udev could know to create it.

It does indeed show hda5 and all of the appropriate information inside 
of it.
I just upgraded udev to 0.40 and did a /etc/init.d/udev restart, and 
/dev/hda5 magically appeared. Weird, I guess it really was a userspace 
issue.

