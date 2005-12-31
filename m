Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVLaBDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVLaBDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLaBDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:03:13 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53907 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751297AbVLaBDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:03:13 -0500
Subject: Re: Machine Check Exception !
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Legend W." <mrwangxc@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <71a51c440512261852u593a2795y@mail.gmail.com>
References: <71a51c440512261852u593a2795y@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Dec 2005 01:04:55 +0000
Message-Id: <1135991096.28365.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-27 at 10:52 +0800, Legend W. wrote:
> parsebank(0): b20000001040080f @ 3
>         External tag parity error
>         CPU state corrupt. Restart not possible
>         Error enabled in control register
>         Error not corrected.
>         Bus and interconnect error
>         Participation: Local processor originated request
>         Timeout: Request did not timeout
>         Request: Generic error
>         Transaction type : Invalid
>         Memory/IO : Other
> 
> Can anybody please enlighten me what this means or what a possible
> problem behind might be?

Executive summary - your hardware is broken. In this case its reporting
a parity error on external tag bits - presumably cache bits. "Contact
your system vendor for advice" as they say 8)

