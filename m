Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272282AbRIETbG>; Wed, 5 Sep 2001 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272287AbRIETaz>; Wed, 5 Sep 2001 15:30:55 -0400
Received: from [209.38.98.99] ([209.38.98.99]:29631 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S272282AbRIETan>;
	Wed, 5 Sep 2001 15:30:43 -0400
Message-Id: <200109051931.f85JVUf11156@srvr201.castmark.com>
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: joe.mathewson@btinternet.com, Joseph Mathewson <joe@mathewson.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Date: Wed, 5 Sep 2001 14:30:57 -0500
X-Mailer: KMail [version 1.3]
In-Reply-To: <200109051913.f85JD2K01304@ambassador.mathewson.int>
In-Reply-To: <200109051913.f85JD2K01304@ambassador.mathewson.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One possible solution might be samba, but I'd be lying if I asserted anything 
about its security, I do know that it can be configured to operate entirely 
over SSL though.

Fred

__________________________________________________ 
On Wednesday 05 September 2001 02:13 pm, Joseph Mathewson wrote:
> Sorry to ask another annoying question so quickly after my SCSI problems,
> but
>
> Does anyone know of/use a secure network filesharing system on a Linux
> network?  We currently have a room of about 10 machines, mostly Linux
> clients (some MacOS X, soon to come Sun and HP-UX boxes) and servers (all
> running Linux).
>
> For some time now, we've been using NFS for filesharing /home and have been
> extremely concerned about security.  All the clients in theory run the same
> uids/gids, thanks to LDAP, but that doesn't stop someone plugging in an
> unauthorized machine and merrily destroying everyone's home directories.
>
> Apparently some work was done to Kerberize various bits of NFS, and Sun
> have a secure(r) implementation in Solaris.
>
> Does anyone know of a free (preferably easy :) way of secure Linux <->
> Linux filesharing?  Apologies if that seems like a flame, maybe I've missed
> the obvious solution.  (Preferably a solution that doesn't involve editing
> /etc/exports to only allow connections from specified IPs, because if
> someone was going to go to the length of destroying our data, they could
> fake that.  Similarly, MAC addresses.)
>
> Joe.
>
> +-------------------------------------------------+
>
> | Joseph Mathewson <joe@mathewson.co.uk>          |
>
> +-------------------------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
