Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVDERxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVDERxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVDERuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:50:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26334 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261861AbVDERm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:42:29 -0400
Date: Tue, 5 Apr 2005 10:42:25 -0700 (PDT)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, ioe-lkml@axxeo.de, matthew@wil.cx,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: Re: [PATCH] network configs: disconnect network options from drivers
In-Reply-To: <20050404195051.GA12364@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0504051033310.5053@localhost.localdomain>
References: <20050330234709.1868eee5.randy.dunlap@verizon.net>
 <20050331185226.GA8146@mars.ravnborg.org> <424C5745.7020501@osdl.org>
 <20050331203010.GA8034@mars.ravnborg.org> <4250B4C5.2000200@osdl.org>
 <20050404195051.GA12364@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Sam Ravnborg wrote:

>
> Only bit that I am worried about is the statement in SCTP:
> 	depends on IPV6 || IPV6=n
>
> That looked like a noop to me. It had the sideeffect that SCTP
> menu entries where idented an extra level which was not desireable
> with currect layout.
>

No. This is not a noop. This is required to restrict SCTP configured as
static when IPV6 is configured as module.

Thanks
Sridhar
