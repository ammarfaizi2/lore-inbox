Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUHFNWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUHFNWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUHFNWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:22:51 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:46744 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S268134AbUHFNWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:22:46 -0400
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org, "Buddy Lumpkin" <b.lumpkin@comcast.net>
Subject: Re: EXT intent logging
References: <S268081AbUHFEzL/20040806045511Z+197@vger.kernel.org>
	<87zn58lhb1.fsf@enki.rimspace.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Fri, 06 Aug 2004 09:22:38 -0400
In-Reply-To: <87zn58lhb1.fsf@enki.rimspace.net> (Daniel Pittman's message of
 "Fri, 06 Aug 2004 19:57:54 +1000")
Message-ID: <87pt64o0yp.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman <daniel@rimspace.net> writes:

> What is normal is that ext3 will perform an *occasional* fsck - by
> default, once a month or every thirty-odd mounts - to catch any
> corruption that has been missed by the journaling.

And if you don't want this to happen, you can use 'tunefs' to turn it
off, and rely entirely on journal replays.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
