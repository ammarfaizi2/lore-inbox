Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUK0Cpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUK0Cpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUK0CmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:42:24 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:61927 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262824AbUK0Cis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 21:38:48 -0500
Message-ID: <41A7E8AD.9050405@g-house.de>
Date: Sat, 27 Nov 2004 03:38:37 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Aleksandar Milivojevic <amilivojevic@pbl.ca>
Subject: Re: network console
References: <41A78D0A.5060308@pbl.ca>
In-Reply-To: <41A78D0A.5060308@pbl.ca>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksandar Milivojevic schrieb:
> Has anybody attempted to implement console on network interface (with or

please read Documentation/networking/netconsole.txt.

> If such a beast exists, what would be required on the client side?
> Linux-only client, or is there Windows client too?

client? well, the machine with netconsole-enabled kernel would be the
"client", the machine with the syslog daemon would be the "server".

-- 
BOFH excuse #202:

kernel panic: write-only-memory (/dev/wom0) capacity exceeded.
