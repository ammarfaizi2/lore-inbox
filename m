Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUJJWlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUJJWlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUJJWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:41:12 -0400
Received: from smtp06.web.de ([217.72.192.224]:60072 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S268533AbUJJWlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:41:09 -0400
Message-ID: <4169BA7D.3030306@web.de>
Date: Mon, 11 Oct 2004 00:41:01 +0200
From: Michael Thonke <tk-shockwave@web.de>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040930)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple questions:

- Is it possible to boot with an empty /dev, until udev builds it ?

No, it isn't as far as I know.

- If this is not the case, which are the minimal nodes that should be
  present ?
/dev/null and /dev/console is needed to boot into the envoirment

- For any answer to previous question, shouldn't the distro set up minimal
  /dev (empty or with a few nodes) and _delete_ the old /dev tree ?

At least I could do so, but at the moment /dev are also elemental for some distros..I have moved with gentoo and have had no problems along x86 32bit
but x86_64 driving me creazy

I you want more to know have a look at decibiles udev primer
Greets Michael

