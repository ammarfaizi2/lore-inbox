Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269332AbUJQXvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269332AbUJQXvu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUJQXvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:51:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38835 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269332AbUJQXvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:51:48 -0400
Subject: Re: [RFC][PATCH] inotify 0.14
From: Robert Love <rml@novell.com>
To: V13 <v13@priest.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <200410180246.27654.v13@priest.com>
References: <1097808272.4009.0.camel@vertex>
	 <200410180246.27654.v13@priest.com>
Content-Type: text/plain
Date: Sun, 17 Oct 2004 19:52:09 -0400
Message-Id: <1098057129.5497.107.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 02:46 +0300, V13 wrote:

>   AFAICS this patch adds inotify and removes dnotify. I believe that the 
> addition of inotify to 2.6 series (if it is going to happen) should leave 
> dnotify intact since there may be programs that rely on it (kde for example).

It should make dnotify a configuration option, controlled via
CONFIG_DNOTIFY.

	Robert Love


