Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWEAO4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWEAO4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEAO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:56:36 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:7133 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932126AbWEAO4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:56:35 -0400
Date: Mon, 1 May 2006 10:56:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/4] MultiAdmin module
In-Reply-To: <Pine.LNX.4.61.0605011549460.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605011054020.31205@d.namei>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0605011549460.31804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2006, Jan Engelhardt wrote:

> +#if !defined(CONFIG_SECURITY_CAPABILITIES) && \
> +    !defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
> +#        error You need to have CONFIG_SECURITY_CAPABILITIES=y or =m \
> +               for MultiAdmin to compile successfully.
> +#endif

This is what Kconfig language is for.

> +typedef int bool;

You won't get much worthwile review of this code until you clean it up and 
make it conform to kernel coding style.


- James
-- 
James Morris
<jmorris@namei.org>
