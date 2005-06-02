Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFBMec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFBMec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFBMe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:34:29 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:18151 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261395AbVFBMeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:34:24 -0400
X-ORBL: [69.150.57.195]
Date: Thu, 2 Jun 2005 07:32:19 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: James Morris <jmorris@redhat.com>
Cc: Greg KH <greg@kroah.com>, Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602123219.GB8855@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050602073303.GA9373@kroah.com> <Xine.LNX.4.44.0506020329050.4151-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0506020329050.4151-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:33:58AM -0400, James Morris wrote:
> Break up your patch and send it in logical chunks, so it can be
> reviewed easily.

In discussions with some developers from JFS and CIFS, it was
suggested that the best thing would be to submit one patch with the
whole contents of the fs/ecryptfs directory, since it is a new
filesystem with no modifications to existing code.  What sort of
logical chunks would you consider to be appropriate?  Separate patches
for each file (inode.c, file.c, super.c, etc.), which represent sets
of functions for each major VFS object?

Thanks,
Mike
