Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264210AbUD0RY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUD0RY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUD0RY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:24:57 -0400
Received: from mailoff.mtu.edu ([141.219.70.111]:27804 "EHLO mailoff.mtu.edu")
	by vger.kernel.org with ESMTP id S264210AbUD0RYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:24:55 -0400
Message-ID: <408E9771.7020302@mtu.edu>
Date: Tue, 27 Apr 2004 13:25:05 -0400
From: Adam Jaskiewicz <ajjaskie@mtu.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca>
In-Reply-To: <20040427165819.GA23961@valve.mbsi.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually, we also have no desire nor purpose to prevent tainting. The purpose
>of the workaround is to avoid repetitive warning messages generated when
>multiple modules belonging to a single logical "driver"  are loaded (even when
>a module is only probed but not used due to the hardware not being present).
>Although the issue may sound trivial/harmless to people on the lkml, it was a
>frequent cause of confusion for the average person.
>
Would it not be better to simply place a notice in the readme explaining 
what
the error messages mean, rather than working around the liscense checking
code? Educate the users, rather than fibbing.

--
Adam Jaskiewicz

