Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285356AbRLGBGj>; Thu, 6 Dec 2001 20:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285357AbRLGBGa>; Thu, 6 Dec 2001 20:06:30 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:10624
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285356AbRLGBGS>; Thu, 6 Dec 2001 20:06:18 -0500
Date: Thu, 6 Dec 2001 19:57:10 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <stoffel@casc.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011206195710.A1949@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Stoffel <stoffel@casc.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16C2HM-0002JR-00@the-village.bc.nu> <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there>; from landley@trommello.org on Thu, Dec 06, 2001 at 05:03:12AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> P.S.  Can we seperate "add new subsystem y prime" and "remove old subsystem 
> y".  LIke the new and old SCSI error handling, which have been in the tree in 
> parallel for some time?  Did I hear Eric ever suggest removing the old 
> configurator for 2.4?  Anybody?

The whole point of putting the new configurator in would be to be able
to drop the old one out.

But that would be strictly Marcelo's call.  It would be up to him to decide
whether the tradeoff were worth it.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything you know is wrong.  But some of it is a useful first approximation.
