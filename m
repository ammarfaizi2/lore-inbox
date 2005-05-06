Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVEFTtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVEFTtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVEFTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 15:49:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46267 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261283AbVEFTtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 15:49:41 -0400
Date: Fri, 6 May 2005 15:49:37 -0400
From: Dave Jones <davej@redhat.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: Re: [PATCH][RESEND]drivers/scsi/megaraid/megaraid_{mm,mbox}
Message-ID: <20050506194937.GA27019@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"Ju, Seokmann" <sju@lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE54@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE54@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 03:43:37PM -0400, Bagalkote, Sreenivas wrote:
 > I am resending a patch sent by Seokmann Ju on Mar 17, 2005.
 > 
 > Signed-off-by: Sreenivas Bagalkote <sreenivas.bagalkote@lsil.com>
 > 
 > diff -Naur old/Documentation/scsi/ChangeLog.megaraid
 > new/Documentation/scsi/ChangeLog.megaraid
 > --- old/Documentation/scsi/ChangeLog.megaraid	2005-03-17
 > 09:54:51.780719824 -0500
 > +++ new/Documentation/scsi/ChangeLog.megaraid	2005-03-17
 > 09:14:03.247953384 -0500
 > @@ -1,3 +1,69 @@
 > +Release Date	: Mon Mar 07 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
 > +Current Version	: 2.20.4.6 (scsi module), 2.20.2.6 (cmm module)
 > +Older Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
 > +
 > +1.	Added IOCTL backward compatibility.
 > +	Convert megaraid_mm driver to new compat_ioctl entry points.
 > +	I don't have easy access to hardware, so only compile tested.
 > +		- Signed-off-by:Andi Kleen <ak@muc.de>
 > +

This all belongs in the SCM metadata, not in the patch itself.

		Dave

