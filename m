Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVAYQwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVAYQwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVAYQwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:52:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39409 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261907AbVAYQwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:52:33 -0500
Date: Tue, 25 Jan 2005 08:52:00 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20050125165200.GA30003@us.ibm.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BCCC6@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BCCC6@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atul -

On Tue, Jan 25, 2005 at 11:27:36AM -0500, Mukker, Atul wrote:
> After writing the "- - -" to the scan attribute, the management applications
> assume the udev has created the relevant entries in the /dev directly and
> try to use the devices _immediately_ and fail to see the devices
> 
> Is there a hotplug event which would tell the management applications that
> the device nodes have actually been created now and ready to be used?

Read the udev man page section, the part right before "FILES". Try
putting a script under /etc/dev.d/default/*.dev. Then you can get more
specific with an /etc/dev.d/scsi/*.dev script or something else.

I just tried something simple but did not get it working.

Try linux-hotplug-devel@lists.sourceforge.net list for help.

-- Patrick Mansfield
