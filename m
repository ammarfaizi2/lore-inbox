Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUJRCSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUJRCSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 22:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUJRCSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 22:18:36 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:11233 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S269358AbUJRCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 22:18:27 -0400
Subject: Re: [RFC][PATCH] inotify 0.14
From: John McCutchan <ttb@tentacle.dhs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Robert Love <rml@novell.com>, v13@priest.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <20041018113237.4c4c1d11.sfr@canb.auug.org.au>
References: <1097808272.4009.0.camel@vertex>
	 <200410180246.27654.v13@priest.com> <1098057129.5497.107.camel@localhost>
	 <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
	 <20041018113237.4c4c1d11.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098065866.16758.0.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 22:17:46 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.1.0, Antispam-Data: 2004.10.17.0
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 21:32, Stephen Rothwell wrote:
> On Mon, 18 Oct 2004 11:28:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >
> > And you create setattr_mask_dnotify for which I can find no caller.
> 
> Similarly setattr_mask_inotify appears to have no callers (I assume it is
> left over from a previous version).

Yes it is. setattr_mask () computes both dnotify and inotify masks.

John

