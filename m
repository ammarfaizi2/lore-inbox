Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288481AbSAHWDg>; Tue, 8 Jan 2002 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSAHWDR>; Tue, 8 Jan 2002 17:03:17 -0500
Received: from codepoet.org ([166.70.14.212]:22537 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288486AbSAHWCZ>;
	Tue, 8 Jan 2002 17:02:25 -0500
Date: Tue, 8 Jan 2002 15:02:25 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre2
Message-ID: <20020108220225.GA342@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1010460206.8690.0.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010460206.8690.0.camel@tiger>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 07, 2002 at 10:23:25PM -0500, Louis Garcia wrote:
> The radeonfb is still broken from the update in pre1. I have attached
> the missing parts of that update. This is from Ani Joshi himself.

Also looks like drivers/video/radeonfb.c needs to be fixed
to cope with newer binutils....

+#ifdef MODULE
        remove:         radeonfb_pci_unregister,
+#endif

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
