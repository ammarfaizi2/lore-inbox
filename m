Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUE3SgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUE3SgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 14:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUE3SgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 14:36:15 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:4369 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262322AbUE3SgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 14:36:14 -0400
Date: Sun, 30 May 2004 20:36:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andries Brouwer <aeb@cwi.nl>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040530183609.GB5927@pclin040.win.tue.nl>
References: <40BA2213.1090209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BA2213.1090209@pobox.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 02:04:03PM -0400, Jeff Garzik wrote:

> So it seems that the 2.6.x geometry code breaks dual booting, since 
> Windows wants "sane" CHS values.  See the thread on slashdot, or 
> http://www.redhat.com/archives/fedora-devel-list/2004-May/msg00908.html
> 
> Although Fedora Core is current taking grief for this, it's really a 
> 2.6.x kernel problem AFAICT.
> 
> Has anybody taken the time to hunt down the csets that cause this 
> massive partition table breakage?  If so, it will save me some time 
> tracking this down.

Hi Jeff,

The link you give describes a user space problem.
The fdisk versions that I maintain all work fine - apparently
Fedora Core uses something else to change partition tables,
and that something else makes assumptions that are invalid.
(Maybe it uses parted?)

I can tell you in great detail all about disk geometry,
and the 2.4 situation and the 2.6 situation.

Andries
aeb@cwi.nl


