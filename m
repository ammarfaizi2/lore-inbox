Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJLOdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 10:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTJLOdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 10:33:03 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:30900 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261869AbTJLOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 10:33:01 -0400
Date: Sun, 12 Oct 2003 16:32:45 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Mark Williams (MWP)" <mwp@internode.on.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
Message-ID: <20031012143245.GA21010@louise.pinerecords.com>
References: <20031012121331.GA665@linux.comp> <yw1xhe2eiqru.fsf@zaphod.guide> <20031012140048.GA554@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012140048.GA554@linux.comp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-12 2003, Sun, 23:30 +0930
Mark Williams (MWP) <mwp@internode.on.net> wrote:

> > "Mark Williams (MWP)" <mwp@internode.on.net> writes:
> > 
> > > I am having rather ugly problems with this card using the PDC20269 chip.
> > > Almost as soon as either of the HDDs on the controller are used, the
> > > kernel hangs solid with a dump of debugging info.
> > 
> > That dump could be useful.  Also full output of dmesg and "lspci -vv"
> > can be helpful.
> 
> Ok, seems this is not a controller fault, but really a problem with
> ReiserFS (!!).

Do you really expect reiserfs code (or any other fs code for that matter)
not to choke on a corrupted filesystem?

Put the disk on a trusted controller and fsck.

-- 
Tomas Szepe <szepe@pinerecords.com>
