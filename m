Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVFMPTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVFMPTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFMPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:17:53 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:18704 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVFMPRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=FFD4jMF0LD6ChMmRto4K/I+mc+qegaW2bbUoNQg2lW2q0od9KHqpkKvORMdt2s81BKvYGDNJozrSg9HMB1kJ0Lg2nKotUCZs4JhIJgRrCm+HAkgq9xZg2ZKBSqt0S/gtxBy+5Dvxt+dR0QEZdHHEFnDDDkjgePwWitgMYRJ4uM4=
Date: Mon, 13 Jun 2005 17:17:08 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613151708.GB12057@gmail.com>
References: <20050530150950.GA14351@gmail.com> <1117467248.4913.9.camel@mulgrave> <20050530160147.GD14351@gmail.com> <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118674783.5079.9.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 09:59:43AM -0500, James Bottomley wrote:

> Actually, the kernel appears to be wrong:

Oops, sorry, I took my grub conf and edited the bad entry :

title 2.6.12-rc6
#kernel (hd0,2)/bzImage-2.6.12-rc6 root=/dev/sdc2 parport=auto video=vesafb:mtrr,ywrap,1024x800-16@75 vga=0xF07
kernel (hd0,2)/bzImage-2.6.12-rc5 root=/dev/sdc2 parport=auto video=vesafb:mtrr,ywrap,1024x800-16@75 vga=0xF07 console=ttyS0

to take the second option with the "console=ttyS0" and forgot to update
it to (hd0,2)/bzImage-2.6.12-rc6.

Sorry for it, I can reboot my computer at 9pm (vdr is reccording till
9pm) and then I post the result :)

And don't worry, it's a vanilla 2.6.12-rc6 with only the scsi-misc and
the last patch, I even didn't patch for latest DVB.
-- 
	Grégoire Favre
