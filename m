Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbSACJXx>; Thu, 3 Jan 2002 04:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbSACJXn>; Thu, 3 Jan 2002 04:23:43 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:36742
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285287AbSACJXa>; Thu, 3 Jan 2002 04:23:30 -0500
Date: Thu, 3 Jan 2002 04:09:24 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103040924.B6936@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102220333.A26713@thyrsus.com> <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> <20020102220333.A26713@thyrsus.com> <4115.1010049288@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4115.1010049288@redhat.com>; from dwmw2@infradead.org on Thu, Jan 03, 2002 at 09:14:48AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> Eric, what are you doing to do if you _do_ detect that there are ISA slots 
> present? If there are ISA (not isapnp) cards present, you'll _have_ to 
> start asking 'difficult' questions. So why bother to detect the ISA slots 
> automatically? Just hide the ISA_SLOTS option in idiotmode. 

You have my intentions backwards. What I'd like to be able to do is
suppress ISA_SLOTS when there are detectably *no* ISA cards.  Unfortunately
I have had it demonstrated that the DMI tables can give false negatives
(false positives would not have been a showstopper).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

What, then is law [government]? It is the collective organization of
the individual right to lawful defense."
	-- Frederic Bastiat, "The Law"
