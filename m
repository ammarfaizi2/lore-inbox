Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJYXTF>; Fri, 25 Oct 2002 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJYXTF>; Fri, 25 Oct 2002 19:19:05 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:52496
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261678AbSJYXTE>; Fri, 25 Oct 2002 19:19:04 -0400
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <3DB9D1FE.5010607@sktc.net>
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
	<3DB9CC5D.7000600@pobox.com>  <3DB9D1FE.5010607@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 19:25:09 -0400
Message-Id: <1035588310.734.4165.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 19:21, David D. Hagood wrote:

> Might I suggest "subcore", since that's really what it is - a sub-core 
> in the main chip.
> 
> My siblings are distinct entities from me, my sub-parts aren't.
> (now, were I part of a cojoined twin....)

Sibling makes sense if you look at the N processors in the package as
"siblings of each other" i.e. not a hierarchy (as subcore implies) but
just a "set of virtual processors in the same core".

If there are subcores, then I think there must be some major core.  If
two chips are siblings, then that merely says they are related (in this
case, the same parent package).

	Robert Love

