Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271831AbTHDQKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTHDQKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:10:34 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:36317 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S271831AbTHDQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:10:32 -0400
Date: Mon, 4 Aug 2003 16:36:06 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nivedita Singhvi <niv@us.ibm.com>,
       Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030804163606.Q639@nightmaster.csn.tu-chemnitz.de>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3F2C0C44.6020002@pobox.com>; from jgarzik@pobox.com on Sat, Aug 02, 2003 at 03:08:52PM -0400
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19jhum-0003rB-00*vFn3hP0u2Ks*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat, Aug 02, 2003 at 03:08:52PM -0400, Jeff Garzik wrote:
> So, fix the other end of the pipeline too, otherwise this fast network 
> stuff is flashly but pointless.  If you want to serve up data from disk, 
> then start creating PCI cards that have both Serial ATA and ethernet 
> connectors on them :)  Cut out the middleman of the host CPU and host 
> memory bus instead of offloading portions of TCP that do not need to be 
> offloaded.

Exactly what I suggested: sys_ioroute()

"Providing generic pipelines and io routing as Linux service"
Msg-ID: <20030718134235.K639@nightmaster.csn.tu-chemnitz.de>

on linux-kernel and linux-fsdevel

Be my guest.

I know, that you mean doing it in hardware, but you cannot
accelerate sth. which the kernel doesn't do ;-)

Regards

Ingo Oeser
