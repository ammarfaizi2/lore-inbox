Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265601AbSJXTFv>; Thu, 24 Oct 2002 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSJXTFv>; Thu, 24 Oct 2002 15:05:51 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34941 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265601AbSJXTFu>; Thu, 24 Oct 2002 15:05:50 -0400
Date: Thu, 24 Oct 2002 15:11:49 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: erich@uruk.org
Cc: Matthias Welk <matthias.welk@fokus.gmd.de>,
       Manfred Spraul <manfred@colorfullife.com>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024151149.A7373@devserv.devel.redhat.com>
References: <200210241948.38490.matthias.welk@fokus.fraunhofer.de> <E184nEw-00071m-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E184nEw-00071m-00@trillium-hollow.org>; from erich@uruk.org on Thu, Oct 24, 2002 at 12:01:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 12:01:54PM -0700, erich@uruk.org wrote:
> The perfect peak performance of your setup, if the cache implements
> standard write-allocate behavior (the target cache line is read before it
> is written because the write logic doesn't know you're going to overwrite
> the whole line in cases like this), should be:

the point is to avoid the (in this case bad) write allocate...

