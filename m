Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbRDQS5q>; Tue, 17 Apr 2001 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRDQS5g>; Tue, 17 Apr 2001 14:57:36 -0400
Received: from spc2.esa.lanl.gov ([128.165.67.191]:17798 "HELO
	spc2.esa.lanl.gov") by vger.kernel.org with SMTP id <S132811AbRDQS5Q>;
	Tue, 17 Apr 2001 14:57:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.1.4 is available
Date: Tue, 17 Apr 2001 13:03:22 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010417141335.A32711@thyrsus.com>
In-Reply-To: <20010417141335.A32711@thyrsus.com>
MIME-Version: 1.0
Message-Id: <01041713032200.01250@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2001 12:13, Eric S. Raymond wrote:
> The latest version is always available at http://www.tuxedo.org/~esr/cml2/
>
> Release 1.1.4: Tue Apr 17 14:02:17 EDT 2001
> 	* Tom Rini's patches for the ARM port tree.
> 	* Correct handling of booleans when trits are disabled.
> 	* `nohelp' tie symbol introduced.
> 	* Code audited with PyChecker.
>
> The fact that most of the arguments about recent releases have to do with
> color selection in the UI tells me that the UI is just about good enough.
> The sluggishness complaints seem to have subsided as well.
>
> So let's try to shift our attention to auditing and fixing the rules files,
> shall we?

Using CML2 1.1.4 to make xconfig for 2.4.4-pre3:

I hope this falls into one of the above categories, but now with CONFIG_MODULES
set to y, I don't see any of the y m n choices colored in with the usual magenta.
This is true on all menus. The label text is green for those set to y, but this hasn't 
been 100% reliable in the past.

On the other hand, with CONFIG_MODULES set to n, your fix seems to have worked.

So, one step forward, one step back. 

Steven


