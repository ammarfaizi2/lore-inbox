Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTIKL0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTIKL0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:26:39 -0400
Received: from mail.skjellin.no ([80.239.42.67]:19666 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261216AbTIKL0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:26:38 -0400
Message-ID: <3F605BF2.7030001@tomt.net>
Date: Thu, 11 Sep 2003 13:26:42 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Bickle <ebickle@healthspace.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem: IDE data corruption with VIA chipsets on 2.4.20-19.8+others
References: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
In-Reply-To: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Bickle wrote:
> The core issue:
> ----------------
> Random crashes, general operating system instability with a RedHat 8 Linux
> install running a moderately heavy-use database server (IBM Lotus Domino 5
> or 6). All current indications point to a data
> corruption/ide-incompatibility between the linux IDE driver and various VIA
> chipsets. The problem only occurs during heavy database server load.
<snip long story>

If I didn't misread your story, the other common issue is Red Hat's 
kernel, wich is heavily patched with several good (and not so good) 
patches. You may have better luck with mainline 2.4.22 (kernel.org).

In any case Red Hat kernel problems should probably be reported to Red 
Hat, their bugzilla comes to mind.

-- 
Cheers,
André Tomt
andre@tomt.net

