Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSBDPFH>; Mon, 4 Feb 2002 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSBDPFD>; Mon, 4 Feb 2002 10:05:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289011AbSBDPEy>;
	Mon, 4 Feb 2002 10:04:54 -0500
Message-ID: <3C5EA30D.8B51C639@mandrakesoft.com>
Date: Mon, 04 Feb 2002 10:04:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Stephen Lord <lord@sgi.com>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org> <3C5D3DE9.4080503@sgi.com> <20020203140926.GA14532@tapu.f00f.org> <3C5D51A0.4050509@sgi.com> <20020203224406.GA17396@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Sun, Feb 03, 2002 at 09:05:04AM -0600, Stephen Lord wrote:
> 
>     I agree is is not a big issue in this case - my interpretation of
>     tails was the end of any file could be packed, but if it is only
>     small files.....
> 
> But you can't mmap (say) a 1k file right now...  so right now this

huh?  You can mmap a file of any size > 0.  Is this a reiserfs
limitation or something?

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
