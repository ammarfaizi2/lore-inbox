Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRADVtM>; Thu, 4 Jan 2001 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRADVtC>; Thu, 4 Jan 2001 16:49:02 -0500
Received: from jalon.able.es ([212.97.163.2]:2557 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129538AbRADVst>;
	Thu, 4 Jan 2001 16:48:49 -0500
Date: Thu, 4 Jan 2001 22:48:37 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Mike <mike@khi.sdnpk.org>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "linux-irda @ pasta . cs . UiT . No" <linux-irda@pasta.cs.UiT.No>
Subject: Re: INIT: No inittab file found
Message-ID: <20010104224837.C1148@werewolf.able.es>
In-Reply-To: <3A548636.27C231BA@khi.sdnpk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A548636.27C231BA@khi.sdnpk.org>; from mike@khi.sdnpk.org on Thu, Jan 04, 2001 at 15:18:30 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.04 Mike wrote:
> Hi,
> 
> I am unable to boot my linux. I got the following message during boot.
> 
> ====================================================
> INIT: No inittab file found
> INIT: Can't open(/etc/ioctl.save, O_WRONLY): No such file or directory
> 
> Enter Runlevel:
> =====================================================
> 

Try answering 'single'. That boots into 'single user mode': no
daemons, no try to load inittab. Just a shell to let you check if
there exists an /etc/inittab file.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
