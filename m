Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQJ0B3W>; Thu, 26 Oct 2000 21:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129938AbQJ0B3M>; Thu, 26 Oct 2000 21:29:12 -0400
Received: from ns.caldera.de ([212.34.180.1]:59405 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129722AbQJ0B3H>;
	Thu, 26 Oct 2000 21:29:07 -0400
Date: Fri, 27 Oct 2000 03:28:22 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Mauelshagen@sistina.com, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-lvm@msede.com, mge@sistina.com
Subject: Re: [linux-lvm] Re: LVM snapshotting broken?
Message-ID: <20001027032822.A9936@caldera.de>
Mail-Followup-To: Mauelshagen@sistina.com,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-lvm@msede.com, mge@sistina.com
In-Reply-To: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva> <20001026233707.A12201@srv.t-online.de> <20001027015308.A5034@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001027015308.A5034@caldera.de>; from hch@caldera.de on Fri, Oct 27, 2000 at 01:53:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 01:53:08AM +0200, Christoph Hellwig wrote:
> Look like a structure mis-match to me, although lv_v2_t is the same for
> all tools.

Sorry I was wrong. The __unused field is missing.
Yet another reason for an official 0.8 maintaince release ;)

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
