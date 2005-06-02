Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVFBAEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVFBAEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFBAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:04:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63207 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261542AbVFBAEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:04:25 -0400
Date: Thu, 2 Jun 2005 01:05:08 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to replace an executing file on an embedded system?
Message-ID: <20050602000508.GD29811@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com> <E1Ddclx-0002MM-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Ddclx-0002MM-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:37:17AM +0200, Bernd Eckenfels wrote:
> In article <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com> you wrote:
> > What am I missing?  How am I supposed to replace files that
> > are being executed?
> 
> The problem is that a unlinked file which is open will be removed from the
> filesystem on close. I think this is not new. You can make init reexecute
> itself (telinit u)

With sysvinit you can, that is.  And no, this behaviour of umount is nothing
new, of course - wrongbot is just being its usual self.
