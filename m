Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTIIBDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTIIBDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:03:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1156 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263846AbTIIBDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:03:42 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Dennis Freise <Cataclysm@final-frontier.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908225401.GD681@redhat.com>
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org>
	 <20030908225401.GD681@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 02:02:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 23:54, Dave Jones wrote:
>  > agpgart (modified by ATI, I suppose) is
>  > included in form of sourcecode, being compiled on installation. Dunno what
>  > else could violate GPL :)
> 
> Linking GPL code to binary .o files, and then disabling the
> MODULE_LICENSE("GPL") smells pretty fishy to me.

If all the code they include is their own then they could have dual
licensed it. If not and they are modifying core kernel code to add hooks
for their code they aren't likely to get past the preliminary arguments 
about a GPL violation and it being a derivative work.


