Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbTAMHmD>; Mon, 13 Jan 2003 02:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTAMHmC>; Mon, 13 Jan 2003 02:42:02 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:15633 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S261409AbTAMHmB>; Mon, 13 Jan 2003 02:42:01 -0500
Date: Mon, 13 Jan 2003 07:49:12 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Dax Kelson <Dax.Kelson@gurulabs.com>
cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS
 [0/6]
In-Reply-To: <1042437391.1677.8.camel@thud>
Message-ID: <Pine.LNX.4.44.0301130745510.26185-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2003, Dax Kelson wrote:

> Standard NFS security/authentication sucks rocks. Without this NFS home
> directory servers are just waiting to be ransacked by a rouge (or
> compromised) root user on a client machine.

AIUI, A root user still can. The users krbv5 credentials will
generally have been cached to storage. (though i suppose one could
mount that storage via NFS and use root_squash, but that's little 
protection.).

> NFSv4 w/RPSEC_GSS is finally a native UNIX filesharing solution that
> I don't have to be ashamed of when hanging with admins of those
> "other OSes".

Unless NFSv4 has dealt with the problem above, it isnt much protection 
from rogue root users.

> Dax

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

