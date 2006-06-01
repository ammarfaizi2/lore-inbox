Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWFALxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWFALxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWFALxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:53:17 -0400
Received: from penda.cc.fh-lippe.de ([193.16.112.79]:19597 "EHLO
	penda.cc.fh-lippe.de") by vger.kernel.org with ESMTP
	id S1750858AbWFALxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:53:17 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 1 Jun 2006 13:53:13 +0200
From: Martin Hierling <martin.hierling@fh-luh.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060601115313.GB4561@cc.fh-luh.de>
References: <20060531164707.GA19547@cc.fh-luh.de> <20060531204716.GL13682@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531204716.GL13682@fieldses.org>
X-URL: http://www.fh-luh.de/skim/netzwerk.html
User-Agent: Mutt/1.5.11
X-Skim-SendBy: pike.cc.fh-luh.de on Thu, 01 Jun 2006 13:53:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruce, Hi List,

 On Wed, May 31, 2006 at 04:47:16PM -0400, J. Bruce Fields wrote:
> On Wed, May 31, 2006 at 06:47:07PM +0200, Martin Hierling wrote:
> > [4] Linux version 2.6.16.18-xen (root@defiant)
> 
> Is there a xen patch applied as well?

sure. 3.0.2-2

> What are your export options?  (Output of exportfs -v)  Also,
> RPC-related CONFIG options would be interesting.  (grep SUNRPC .config)
> Are you using gss/krb5?

/export/packages
                192.168.1.0/24(rw,wdelay,no_root_squash)
/files/incoming
                192.168.1.0/24(rw,async,wdelay,no_root_squash)
/export/portage
                192.168.1.0/24(rw,wdelay,no_root_squash)
/export/overlay
                192.168.1.0/24(rw,wdelay,no_root_squash)
/files/netboot  192.168.1.0/24(rw,wdelay,no_root_squash)
/mnt/tricorder  192.168.1.0/24(rw,wdelay,no_root_squash)
/export/home    192.168.1.0/24(rw,async,wdelay,root_squash)
/nfs/video      192.168.1.0/24(rw,async,wdelay,no_root_squash)


# grep SUNRPC .config
CONFIG_SUNRPC=m

gss/krb5 = No.

regards Martin

-- 
----------------------------------------------------------------
  Ensign Pillsbury: He's bread Jim!
----------------------------------------------------------------
