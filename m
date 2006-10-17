Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWJQWpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWJQWpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWJQWpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:45:23 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:41998 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750827AbWJQWpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:45:22 -0400
Date: Wed, 18 Oct 2006 00:45:21 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VCD not readable under 2.6.18
Message-ID: <20061017224521.GA64471@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com> <1161040345.24237.135.camel@localhost.localdomain> <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com> <1161124732.5014.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161124732.5014.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:38:52PM +0100, Alan Cox wrote:
> Now where it all gets weirder is that some forms of VCD (especially the
> ones for philips short lived interactive stuff) have an ISO file system
> on them but where sector numbers in the file system for video blocks
> point to blocks that are not 2K data blocks but mpeg blocks that the
> file system layer can't handle, so a VCD disk can appear mountable and
> the like.

PSX1 CDs are often like that too.  Video files are in mode2 sectors
but the filesystem is ISO9660.  It's a mix of mjpeg-like and adpcm
instead of mpeg though.

Makes the FIBMAP restrictions annoying too.

  OG.

