Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269335AbUJQXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269335AbUJQXwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUJQXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:52:39 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:2296 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S269335AbUJQXwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:52:37 -0400
Subject: Re: [RFC][PATCH] inotify 0.14
From: John McCutchan <ttb@tentacle.dhs.org>
To: V13 <v13@priest.com>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <200410180246.27654.v13@priest.com>
References: <1097808272.4009.0.camel@vertex>
	 <200410180246.27654.v13@priest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098057149.13216.1.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:52:30 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.1.0, Antispam-Data: 2004.10.16.1
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 19:46, V13 wrote:
> On Friday 15 October 2004 05:44, John McCutchan wrote:
> > Hello,
> >
> > Here is release 0.14.0 of inotify. Attached is a patch to 2.6.8.1
> 
>   AFAICS this patch adds inotify and removes dnotify. I believe that the 
> addition of inotify to 2.6 series (if it is going to happen) should leave 
> dnotify intact since there may be programs that rely on it (kde for example).

This patch makes both inotify and dnotify conditional features. It does
not remove dnotify.

John
