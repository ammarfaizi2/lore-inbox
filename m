Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281935AbRKURbd>; Wed, 21 Nov 2001 12:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281934AbRKURbX>; Wed, 21 Nov 2001 12:31:23 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:21004 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S281927AbRKURbQ>; Wed, 21 Nov 2001 12:31:16 -0500
Message-ID: <3BFBE4DB.44D9ACCF@web-systems.net>
Date: Wed, 21 Nov 2001 18:31:08 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: dalecki@evision.ag
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net> <3BFBDFA5.DDA1CC98@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Heinz-Ado Arnolds wrote:
> >
> > Hi Linus, Hi Alan, Hi all,
> >
> > I have a problem with loading modules for binary formats. The
> > reason for this problem shows up in fs/exec.c search_binary_handler().
> >
> > Starting with linux-2.1.23 (and up to 2.4.14) there was a change
> > in the format and offset of printing the magic number for requesting
> > a handler module. Up to 2.1.22 the statement
> 
> That is a time span of several years during which nobody realized
> there was a problem with this. Therefore I would rather
> request for removal of the whole binfmt-misc stuff (which is ugly
> anyway)
> rather then "fixing it" ;-)

Not really. I asked for this problem back in 1999 but didn't get any
satisfying response. Since that time me and a lot of my friends are
applying this patch to every new kernel we install. For me and many
other the binfmt interface is a great tool and by far not ugly stuff.

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
