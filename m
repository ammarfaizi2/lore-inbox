Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966267AbWKTRlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966267AbWKTRlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966272AbWKTRlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:41:36 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:53451 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S966267AbWKTRlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:41:35 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <gregkh@suse.de>
Subject: Re: kobject_add failed with -EEXIST
Date: Mon, 20 Nov 2006 18:42:22 +0100
User-Agent: KMail/1.8
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4561E290.7060100@gmail.com> <20061120173116.GA27160@suse.de>
In-Reply-To: <20061120173116.GA27160@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201842.22551.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 20. November 2006 18:31 schrieb Greg KH:
> On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
> > Hi!
> > 
> > Does anybody have some clue, what's wrong with the attached module?
> > Kernel complains when the module is insmoded second time (DRIVER_DEBUG
> > enabled):
> 
> I just tried this with 2.6.19-rc6 and it worked just fine, no problems.
> Perhaps you have some userspace program keeping the
> /sys/class/cls_class/cls_device/ files open?

If this is the case, we'd have a denial of service security problem.

	Regards
		Oliver
