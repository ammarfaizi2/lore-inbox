Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWIZI4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWIZI4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIZI4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:56:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750793AbWIZI4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:56:50 -0400
Subject: Re: [PATCH] restore libata build on frv
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4518EA39.40309@pobox.com>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
	 <1159199184.11049.93.camel@localhost.localdomain>
	 <1159258013.3309.9.camel@pmac.infradead.org>  <4518EA39.40309@pobox.com>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:56:20 +0100
Message-Id: <1159260980.3309.22.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 04:52 -0400, Jeff Garzik wrote:
> The irq is a special case no matter how we try to prettyify it.  We need 
> two irqs, and PCI only gives us one per device. 

That's fine -- but don't use zero to mean none. We have NO_IRQ for that,
and zero isn't an appropriate choice.

-- 
dwmw2

