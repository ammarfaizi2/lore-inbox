Return-Path: <linux-kernel-owner+w=401wt.eu-S1750919AbXAOVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXAOVpG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXAOVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:45:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2438 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbXAOVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:45:04 -0500
Date: Mon, 15 Jan 2007 22:45:03 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070115214503.GA56952@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20070115171602.GA23661@dspnet.fr.eu.org> <20070115184540.2b3c4f78@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115184540.2b3c4f78@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 06:45:40PM +0000, Alan wrote:
> On Mon, 15 Jan 2007 18:16:02 +0100
> Olivier Galibert <galibert@pobox.com> wrote:
> 
> > sd 0:0:0:0: SCSI error: return code = 0x08000002
> > sda: Current: sense key: Hardware Error
> >     ASC=0x42 ASCQ=0x0
> 
> I'll give you a clue: The words "Hardware Error".
> 
> Run a SCSI verify pass on the drive with some drive utilities and see
> what happens. If you are lucky it'll just reallocate blocks and decide
> the drive is ok, if not well see what the smart data thinks.

Both smart and the internal blade diagnostics say "everything is a-ok
with the drive, there hasn't been any error ever except a bunch of
corrected ECC ones, and no more than with a similar drive in another
working blade".  Hence my initial post.  "Hardware error" is kinda
imprecise, so I was wondering whether it was unexpected controller
answer, detected transmission error, block write error, sector not
found...  Is there a way to have more information?

  OG.

