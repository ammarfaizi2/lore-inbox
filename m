Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTG1LTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTG1LTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:19:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9609
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263590AbTG1LTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:19:37 -0400
Subject: Re: PATCH: allow 2.6 to build on old old setups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030727185241.3288a973.davem@redhat.com>
References: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
	 <20030727185241.3288a973.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059391858.15438.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:30:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 02:52, David S. Miller wrote:
> >  		    info->hdr->e_machine == EM_SPARCV9) {
> >  			/* Ignore register directives. */
> >  			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
> >  				break;
> >  		}
> > +#endif
> 
> This change is wrong.
> 
> If you're going to do this, it's much better to define it to the
> correct value in this case (which is decimal '13').

Its sparc specific stuff so presumably all sparc stuff had the register
?. I can change and resubmit though - no problem

