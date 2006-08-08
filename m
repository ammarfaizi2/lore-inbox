Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWHHQhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWHHQhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWHHQhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:37:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:32215 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964967AbWHHQhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:37:54 -0400
Message-ID: <44D8BD51.8040206@zytor.com>
Date: Tue, 08 Aug 2006 09:35:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Rodrick <daniel.rodrick@gmail.com>
CC: Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>	 <44D7579D.1040303@zytor.com>	 <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>	 <44D76F26.9@zytor.com> <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
In-Reply-To: <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Rodrick wrote:
> 
> Hi ... so there seem to be no technical feasibily issues, just
> reliabliy / ugly design issues? So one can still go ahead and write a
> Universal Protocol Driver that can work with all (PXE compatible)
> NICs?
> 

For some definition of "all" = meaning "it might work on some of them."

> Are there any issues related to real mode / protected mode?

Yes, a whole bunch of PXE/UNDI stacks are broken in protected mode.

	-hpa
