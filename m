Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTIJMnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTIJMne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:43:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:32906 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262960AbTIJMnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:43:33 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Luca Veraldi <luca.veraldi@katamail.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5F0820.3090003@cyberone.com.au>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <20030910095255.GA21313@mail.jlokier.co.uk>
	 <20030910120729.C14352@devserv.devel.redhat.com>
	 <20030910103752.GC21313@mail.jlokier.co.uk>
	 <20030910124151.C9878@devserv.devel.redhat.com>
	 <02bc01c37789$ebfa9a40$5aaf7450@wssupremo>
	 <3F5F0820.3090003@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063197725.32730.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 13:42:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 12:16, Nick Piggin wrote:
> There was a zero-copy pipe implementation floating around a while ago
> I think. Did you have a look at that? IIRC it had advantages and
> disadvantages over regular pipes in performance.

FreeBSD had one, it was lightning fast until you used the data the other
end of the pipe. Im not sure what happened to it in the long term.


