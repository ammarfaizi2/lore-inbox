Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTDVPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDVPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:06:26 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:41608
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263199AbTDVPGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:06:22 -0400
Date: Tue, 22 Apr 2003 17:21:37 +0200 (CEST)
Message-Id: <20030422.172137.640929487.rene.rebe@gmx.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: mangled isapnp IDs in /proc/bus/isapnp/devices
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1051020403.14880.7.camel@dhcp22.swansea.linux.org.uk>
References: <20030422.114614.846960661.rene.rebe@gmx.net>
	<1051020403.14880.7.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -26.1 (--------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *197zac-00011J-0C*gv/TcOIr7iY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On: 22 Apr 2003 15:06:43 +0100,
    Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2003-04-22 at 10:46, Rene Rebe wrote:
> > Hi all,
> > 
> > is there a reason why the isapnp device id are mangled this way:
> 
> This is how the spec says the names work

Yes - but for userspace tool it would have been easier to export the
raw number; as listed in:

/lib/modules/<ver>/modules.isapnpmap

Now I added the mangling to the auto-detect script here ...

Sincerely,
- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
