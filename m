Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268152AbSISOXO>; Thu, 19 Sep 2002 10:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbSISOXO>; Thu, 19 Sep 2002 10:23:14 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:21749
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268152AbSISOXN>; Thu, 19 Sep 2002 10:23:13 -0400
Subject: Re: Ooops with 2.4.20-pre7-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Underhill <chris@tart.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D89D674.4060402@tart.net>
References: <3D89D674.4060402@tart.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 15:31:49 +0100
Message-Id: <1032445909.26951.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 14:51, Chris Underhill wrote:
> I've seen this oops with 2.4.20-pre5-ac5 and ac6 as well as 2.4.20-pre7-ac2. 
> It will always happen when the startup scripts are running updfstab and kudzu 
> - my machine is running Red Hat 7.3 plus latest patches.
> 
> After the oops happens, the machine is still useable. My previous kernel, 
> 2.4.19-pre10-ac2 does not oops - I suspect there is something in the IDE (or 
> ide/scsi) changes that is the cause.

Thanks. The log of the unregister failure looks nice and clear. Are you
using devfs btw ?

