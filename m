Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUHITtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUHITtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHITsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:48:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:46993 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266894AbUHITrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:47:16 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040809132907.GA1792@openzaurus.ucw.cz>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040809132907.GA1792@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Mon, 09 Aug 2004 15:47:08 -0400
Message-Id: <1092080828.25658.19.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 15:29 +0200, Pavel Machek wrote:

> Funny... you want to create new namespace and argue "no policy".

The idea was to create the simplest namespace possible (simply using the
source path names) since we need _something_ to send to user-space.

However ...

> If you want to translate it to something URI-like, you should
> do that in userspace. 

It is no longer an issue, because the current plan is to tie the events
to kobjects.

	Robert Love


