Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUJNXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUJNXWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUJNXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:22:13 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:5867 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268019AbUJNXVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:21:37 -0400
Message-ID: <416F09EF.6040605@free.fr>
Date: Fri, 15 Oct 2004 01:21:19 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
References: <Pine.LNX.4.44L0.0410141703260.1026-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410141703260.1026-100000@ida.rowland.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F8160CFDFDB0196240B4EDE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F8160CFDFDB0196240B4EDE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Alan Stern wrote:
> On Thu, 14 Oct 2004, Laurent Riffard wrote:
> 
>> Alan Stern wrote: [snip]
>> 
>>> My impression is that this problem arises somewhere within or
>>>  below the free_irq routine.  I don't have the -mm2 sources,
>>> so I can't be any more precise than that.
>> 
>> Here is an updated dmesg for kernel 2.6.9-rc4-mm1. But I'm
>> afraid it won't give more information, as the call stack is
>> identical to the 2.6.9-rc3-mm2 one.
>> 
>> I will try a vanilla kernel if it's needed.
> 
> 
> Yes, try that.  At least if the problem still occurs, it will be
> easier to track down.
> 
> Alan Stern
> 

I just tried kernel 2.6.9-rc4 : it woks fine, there is no oops when 
I rmmod uhci_hcd.

-- 
laurent

--------------enig8F8160CFDFDB0196240B4EDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBbwn8UqUFrirTu6IRAjagAJ9/xGvH0IaQsvDtdjb8FmPnllp4UgCfbhXX
SvgpHKmUE1h4P9sZpZh4jw0=
=pUwA
-----END PGP SIGNATURE-----

--------------enig8F8160CFDFDB0196240B4EDE--
