Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVCCJIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVCCJIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCCJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:08:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261679AbVCCJHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:07:54 -0500
Date: Thu, 3 Mar 2005 04:06:48 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Jes Sorensen <jes@wildopensource.com>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303090647.GC479@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <yq0y8d5dtg9.fsf@jaguar.mkp.net> <20050303085352.GA29955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303085352.GA29955@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:53:53AM -0800, Greg KH wrote:

 > And sometimes, people really want those "big" fixes, and they switch to
 > using the bk-usb patchset, or the bk-scsi patchset.  That happens a lot
 > for when distros work to stabilize their release kernels.

For those that have no intention of staying close to mainline maybe.
The fact is that before a bitkeeper tree (or any other SCM tree) gets
merged with mainline, its subject to change. Sometimes completely dramatic
'throw it all away and start again' changes.  I know this because I've done it,
I know you've done it with pci/usb trees, and various other folks have
done it with their trees.

Pulling whole random subsystem bk snapshots into a vendor tree without
significant review of all contained changesets is the path to madness
unless you're prepared to maintain the resulting mess forever.

		Dave

