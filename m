Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTIHONj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIHONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:13:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:54402 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262353AbTIHONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:13:38 -0400
Subject: Re: kernel header separation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <willy@debian.org>, Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063028303.32473.333.camel@hades.cambridge.redhat.com>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	 <20030903014908.GB1601@codepoet.org>
	 <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	 <20030905211604.GB16993@codepoet.org>
	 <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
	 <1063028303.32473.333.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 15:12:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 14:38, David Woodhouse wrote:
> > __u8 has a very precise meaning defined by Linux.  If you're including
> > a Linux header. that's what you need to worry about.
> 
> It's a kernel-private type. If we're aiming for a clean set of headers,
> then ideally we should avoid gratuitously defining our own types when
> standards already exist.

__u8 is intended to be used by non kernel stuff for headers. Thats why
"__u8" not "u8" - so it doesnt pollute the sacred posix name space and
have us lynched by glibc people

