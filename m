Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVJ2N5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVJ2N5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJ2N5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 09:57:04 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:4225 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751070AbVJ2N5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 09:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRAjBZR6FCMcAHOT6AKowsjO8XqS2nbnECcUkJuDFMDV3oaAvGnEEv7Ok6FgXjichA+r88+4rRCRJl0brRZhscsT4xTNskTCfbS44Io26W6rl+tVoGd9jDHclSHRXa4YqKEckUXieLSkQMGBh58eOZxN+Qr9CXofefOrvHafKbQ=
Message-ID: <9a8748490510290656v3227bd5bl144baee8faa398dc@mail.gmail.com>
Date: Sat, 29 Oct 2005 15:56:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/14] Big kfree NULL check cleanup - drivers/net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jes Sorensen <jes@trained-monkey.org>,
       Matt Porter <mporter@kernel.crashing.org>,
       Michael Chan <mchan@broadcom.com>, linux.nics@intel.com,
       hans@esrac.ele.tue.nl, Santiago Leon <santil@us.ibm.com>,
       Jean Tourrilhes <jt@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
       Michael Hipp <hippm@informatik.uni-tuebingen.de>,
       Jes Sorensen <jes@wildopensource.com>,
       Carsten Langgaard <carstenl@mips.com>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>, prism54-private@prism54.org,
       netdev@vger.kernel.org, Stuart Cheshire <cheshire@cs.stanford.edu>,
       g4klx@g4klx.demon.co.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <43628FCB.9060202@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510132122.48035.jesper.juhl@gmail.com>
	 <43628FCB.9060202@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jesper Juhl wrote:
> > This is the drivers/net/ part of the big kfree cleanup patch.
> >
> > Remove pointless checks for NULL prior to calling kfree() in drivers/net/.
> >
> >
> > Sorry about the long Cc: list, but I wanted to make sure I included everyone
> > who's code I've changed with this patch.
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>
> applied 98% of this
>

Just currious, what bits are the 2% you did not apply?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
