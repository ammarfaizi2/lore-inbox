Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSBDTRM>; Mon, 4 Feb 2002 14:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSBDTRD>; Mon, 4 Feb 2002 14:17:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64272 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285417AbSBDTQo>;
	Mon, 4 Feb 2002 14:16:44 -0500
Message-ID: <3C5EDE19.5EFE566@mandrakesoft.com>
Date: Mon, 04 Feb 2002 14:16:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <1012835730.26397.519.camel@jen.americas.sgi.com> <E16XlK0-0007Wu-00@the-village.bc.nu> <20020204182942.C2092@parcelfarce.linux.theplanet.co.uk> <3C5ED7A6.C28407BA@mandrakesoft.com> <20020204185554.D2092@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Mon, Feb 04, 2002 at 01:49:10PM -0500, Jeff Garzik wrote:
> > hard sector size should always equal sb->blocksize.

>         If you meant that s_blocksize should match get_hardsectsize, I

yes.  get_hardsectsize returns hard sector size, so this is what I
meant.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
