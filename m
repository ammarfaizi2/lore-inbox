Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVAHN6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVAHN6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAHN6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:58:35 -0500
Received: from fyrebird.net ([217.70.144.192]:31637 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S261176AbVAHN6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:58:23 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.82.92):. Processed in 1.603563 secs)
Message-ID: <41DFE447.9030402@fyrebird.net>
Date: Sat, 08 Jan 2005 14:46:47 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for new elf_loader bug?
References: <41DEAF8F.3030107@bio.ifi.lmu.de> <41DFD9CC.9080009@fyrebird.net>
In-Reply-To: <41DFD9CC.9080009@fyrebird.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:

> Hi,
>
> is there already a patch for the new problem with the elf loader, maybe
> in the bitkeeper tree?
>
> http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt
>
> Thanks!
> cu,
> Frank

I made this very very very very very simple patch for kernel 2.4.28:
http://maphia.flowsecurity.org/patch/uselib-2.4.28.patch

The only thing that an attacker can do is to repeat the exploit and
cause a DoS, but it's hard too.


-- 
www.iosn.it * Amministratore Italian Open Source Network
www.fyrebird.net * Fyrebird Hosting Provider - Technical Department
