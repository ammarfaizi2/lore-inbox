Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVJ2LGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVJ2LGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVJ2LGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:06:42 -0400
Received: from doar2.weizmann.ac.il ([132.77.22.87]:52374 "EHLO
	doar2.weizmann.ac.il") by vger.kernel.org with ESMTP
	id S1750941AbVJ2LGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:06:42 -0400
Message-ID: <436357AE.1020605@weizmann.ac.il>
Date: Sat, 29 Oct 2005 13:06:22 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
References: <4360C0A7.4050708@weizmann.ac.il> <200510280850.40609.rob@landley.net> <43623B1B.50309@weizmann.ac.il> <200510282029.46913.rob@landley.net>
In-Reply-To: <200510282029.46913.rob@landley.net>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> On the other hand, umount is supposed to flush all the data
>> by the time it returns yet still it succeeded.
> 
> Is that guaranteed?  Or do you need to pass some weird flag to umount?

I believe this is the default behavior. How otherwise do you know when 
it's safe to eject/disconnect a removable media (floppy, USB 
disk-on-key,...)?

Regards,

Evgeny
