Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263114AbSJGQRC>; Mon, 7 Oct 2002 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJGQRB>; Mon, 7 Oct 2002 12:17:01 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:35365 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S263114AbSJGQQ7>;
	Mon, 7 Oct 2002 12:16:59 -0400
From: <Hell.Surfers@cwctv.net>
To: porter@cox.net, davem@redhat.com, giduru@yahoo.com, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Date: Mon, 7 Oct 2002 17:21:51 +0100
Subject: RE:Re: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034007711227"
Message-ID: <0fc4721201607a2DTVMAIL5@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034007711227
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Suggesting a entire new sub config option seems wise, in this way not only arm ipaqs could benefit, so could 386s , whole series of rejuvinated computers, become useful.

Cheers, Dean.

On 	Mon, 7 Oct 2002 09:22:12 -0700 	Matt Porter <porter@cox.net> wrote:

--1034007711227
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 7 Oct 2002 16:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbSJGPvc>; Mon, 7 Oct 2002 11:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263111AbSJGPvb>; Mon, 7 Oct 2002 11:51:31 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:63154 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S263107AbSJGPva>; Mon, 7 Oct 2002 11:51:30 -0400
Received: from liberty.homelinux.org ([68.2.43.114]) by fed1mtao01.cox.net
          (InterMail vM.5.01.04.05 201-253-122-122-105-20011231) with ESMTP
          id <20021007155705.HRUB14888.fed1mtao01.cox.net@liberty.homelinux.org>;
          Mon, 7 Oct 2002 11:57:05 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id JAA18691;
	Mon, 7 Oct 2002 09:22:12 -0700
Date: Mon, 7 Oct 2002 09:22:12 -0700
From: Matt Porter <porter@cox.net>
To: "David S. Miller" <davem@redhat.com>
Cc: giduru@yahoo.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007092212.B18610@home.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005205238.47023.qmail@web13201.mail.yahoo.com> <20021005.212832.102579077.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021005.212832.102579077.davem@redhat.com>; from davem@redhat.com on Sat, Oct 05, 2002 at 09:28:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Sat, Oct 05, 2002 at 09:28:32PM -0700, David S. Miller wrote:
> Embedded applications tend to have issues which are entirely specific
> to that embedded project.  As such, those are things that do not
> belong in a general purpose OS.

Exactly, every application wants some of the finer details of
kernel operation tuned to their task.

> The common areas, like smaller hashtables or whatever, sure put a
> CONFIG_SMALL_KERNEL option in there and start submitting the
> one-liners here and there that do it.

Ahhh, but you just defeated the ideal of being able to customize
to task.  This is where the hallowed "the user is dumb" theory
bites us in the ass.  A single option to control all these sizing
issues reduces flexibility and that is what the embedded system
designer is looking for.  The ideal situation is if as we work
on all these areas where we can reduce size, we provide fine
grained options to tweak them (with a default desktop/server value
and a default "tiny" value).  You can have this CONFIG_TINY or
whatever, but then we should also provide the ability to tweak
the values exactly how we want in a specific application.  The
tweaking options can be buried under advanced kernel options
with the appropriate disclaimers about shooting yourself in
the foot.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034007711227--


