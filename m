Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVDEVQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVDEVQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVDEVNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:13:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:29232 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262025AbVDEVEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:04:12 -0400
Date: Tue, 5 Apr 2005 23:04:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, ioe-lkml@axxeo.de, matthew@wil.cx,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: Re: [PATCH] network configs: disconnect network options from drivers
Message-ID: <20050405210406.GA10325@mars.ravnborg.org>
References: <20050330234709.1868eee5.randy.dunlap@verizon.net> <20050331185226.GA8146@mars.ravnborg.org> <424C5745.7020501@osdl.org> <20050331203010.GA8034@mars.ravnborg.org> <4250B4C5.2000200@osdl.org> <20050404195051.GA12364@mars.ravnborg.org> <Pine.LNX.4.61.0504051033310.5053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504051033310.5053@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:42:25AM -0700, Sridhar Samudrala wrote:
> On Mon, 4 Apr 2005, Sam Ravnborg wrote:
> 
> >
> >Only bit that I am worried about is the statement in SCTP:
> >	depends on IPV6 || IPV6=n
> >
> >That looked like a noop to me. It had the sideeffect that SCTP
> >menu entries where idented an extra level which was not desireable
> >with currect layout.
> >
> 
> No. This is not a noop. This is required to restrict SCTP configured as
> static when IPV6 is configured as module.

I see now - thanks.

	Sam
