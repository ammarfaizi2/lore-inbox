Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUE0RLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUE0RLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUE0RLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:11:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2434 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264896AbUE0RLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:11:15 -0400
Date: Thu, 27 May 2004 21:11:13 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Message-ID: <20040527211113.B2004@jurassic.park.msu.ru>
References: <20040527194920.A1709@jurassic.park.msu.ru> <1085675193.7179.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1085675193.7179.5.camel@laptop.fenrus.com>; from arjanv@redhat.com on Thu, May 27, 2004 at 06:26:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:26:33PM +0200, Arjan van de Ven wrote:
> how do you flush the disks' writecache then? Halting the disk seems to
> be the only reliable way to do so.

Isn't ide_cacheflush_p() supposed to do that on modern drives?

Ivan.
