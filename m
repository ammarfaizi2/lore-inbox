Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135640AbRDXOHs>; Tue, 24 Apr 2001 10:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135633AbRDXOHi>; Tue, 24 Apr 2001 10:07:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45526 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135631AbRDXOH3>;
	Tue, 24 Apr 2001 10:07:29 -0400
Date: Tue, 24 Apr 2001 10:07:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: ttel5535@artax.karlin.mff.cuni.cz
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.21.0104241550510.12074-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0104240957120.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Tomas Telensky wrote:

> Thanks for the comment. And why not just let it listen to 25 and then
> being run as uid=nobody, gid=mail?

Handling of .forward, for one thing. Or pipe aliases, or...

None of this stuff is unsolvable (e.g. handling of .forward belongs to
MDA, not MTA), but changing that will break existing setups.

