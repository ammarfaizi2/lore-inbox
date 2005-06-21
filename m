Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVFUEP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVFUEP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVFUELh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:11:37 -0400
Received: from smtpout.mac.com ([17.250.248.86]:32232 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261917AbVFUCrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:47:33 -0400
In-Reply-To: <Pine.LNX.4.62.0506201848500.2736@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com> <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain> <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com> <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com> <6DCC9CC1-2B5C-430F-96AC-F36477AC8290@mac.com> <Pine.LNX.4.62.0506201848500.2736@hammer.psislidell.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA15FE63-6286-4A0E-BE3B-21311C68289E@mac.com>
Cc: Erik Slagter <erik@slagter.name>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Problem with 2.6 kernel and lots of I/O
Date: Mon, 20 Jun 2005 22:47:13 -0400
To: Roy Keene <rkeene@psislidell.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2005, at 19:54:23, Roy Keene wrote:
> But the problem doesn't occur with the "local" end, it's with the  
> "recieving" end (which may be the same thing, but mostly it's not,  
> since I tend to reboot the secondary node more).
>
> The problem occurs on the node running `nbd-server' in userspace  
> and not nessicarily having "nbd" support.
>
> "nbd1" is a remote nbd device to the secondary server, which then  
> becomes highly unusable.  I'm not sure what you're attempting to  
> convey to me, as the server that is running raid1_resync (reading  
> from nbd0, which cooresponds with a local nbd-client binding) is  
> perfectly usable in the example I gave, but the remote node is not...

Oh!  Sorry, I got your systems confused.  In that case, you are  
definitely
having a SCSI RAID controller or driver issue.  Please forgive the  
confusion.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

