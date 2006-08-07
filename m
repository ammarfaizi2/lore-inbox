Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWHGQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWHGQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWHGQv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:51:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55516 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932214AbWHGQv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:51:56 -0400
Message-ID: <44D76F26.9@zytor.com>
Date: Mon, 07 Aug 2006 09:49:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Rodrick <daniel.rodrick@gmail.com>
CC: Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>	 <44D7579D.1040303@zytor.com> <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
In-Reply-To: <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Rodrick wrote:
> 
> Agreed. But still having a single driver for all the NICs would be
> simply GREAT for my setup, in which all the PCs will be booted using
> PXE only. So apart from performance / relilability issues, what are
> the technical roadblocks in this?
> 
> I'm sure having a single driver for all the NICs is a feature cool
> enough to die for. Yes, it might have drawbacks like just pointed out
> by Peter, but surely a "single driver for all NIC" feature could prove
> to be great in some systems.
> 

Assuming it works, which is questionable in my opinion.

> But since it does not already exist in the kernel, there must be some
> technical feasibility isse. Any ideas on this?

No, that's not the reason.  The Intel code was ugly, and the limitations 
made other people not want to spend any time hacking on it.

	-hpa

