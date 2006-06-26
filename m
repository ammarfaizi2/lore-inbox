Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933008AbWFZUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbWFZUJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWFZUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:09:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30138 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933008AbWFZUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:09:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2][ 0/2] Cryptoapi deflate fix.
Date: Mon, 26 Jun 2006 22:09:50 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626165135.10864.53686.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165135.10864.53686.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606262209.50749.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 18:51, Nigel Cunningham wrote:
> 
> The deflate module doesn't properly complete the handling of PAGE_SIZE
> chunks of data. This patch corrects that so that it can be used with
> Suspend2.

Well, it also adds the LZF support to the cryptoapi.  These are two different
things.

If you think the deflate modules needs to be fixed, you should post the patch
for it separately, I think.

Rafael
