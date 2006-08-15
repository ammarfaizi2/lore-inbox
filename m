Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWHOK5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHOK5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHOK5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:57:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:63395 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030219AbWHOK5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:57:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][Fix] swsusp: Fix swap_type_of
Date: Tue, 15 Aug 2006 13:01:30 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200608151218.41041.rjw@sisk.pl> <20060815101611.GH7496@elf.ucw.cz>
In-Reply-To: <20060815101611.GH7496@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151301.30311.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 12:16, Pavel Machek wrote:
> On Tue 2006-08-15 12:18:40, Rafael J. Wysocki wrote:
> > There is a bug in mm/swapfile.c#swap_type_of() that makes swsusp only be
> > able to use the first active swap partition as the resume device.
> > Fix it.
> 
> ACK. (And I guess this is 2.6.18 material, right? Or is that fix not
> needed in mainline?) 

Oh, yes I think it is needed.  2.6.18 material, surely.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
