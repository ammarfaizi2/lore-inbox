Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTLOAyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTLOAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 19:54:41 -0500
Received: from main.gmane.org ([80.91.224.249]:62145 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262864AbTLOAyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 19:54:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Sis900 ethernet dropping 70% packets
Date: Mon, 15 Dec 2003 01:54:37 +0100
Message-ID: <yw1xr7z6ew8i.fsf@kth.se>
References: <200312142355.45631.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ds/j73dq1PSCSJLe/u8W4hjv7ps=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond <andrew@walrond.org> writes:

> I'm trying to install a little Via C3 machine with on-board Sis900 ethernet. 
> As usual, I booted my LNX-BBC rescue disk, configured eth0 and tried to scp 
> my distro over, but failed miserably.
>
> Pinging other hosts on the net sees 70-80% packets getting lost.
>
> LNX-BBC rescue cd uses a 2.4.19 kernel
>
> So then I tried a Trinity rescue disk, using a 2.4.21 kernel. Same thing.
>
> Anybody got experience of this? Googling gives wads of people with similar 
> sounding problems, mostly interrupt related, sometimes Vlan related (It's 
> plugged into a Cisco catalyst but I tried a x-over cable to my laptop with 
> the same result, so I don't think thats relevant), but don't see any 
> solutions.
>
> Is this a known-bad interface? The drivers sources don't seem to
> have been touched for a long time which makes me think its unlikely
> that a newer kernel would help, but who knows...

I can only say that my laptop has a sis900, and I've never had any
problems with it.  I'd look for errors elsewhere.  Maybe it's ACPI
related.  ACPI seems to be able to screw up anything.

-- 
Måns Rullgård
mru@kth.se

