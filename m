Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCADUk>; Wed, 28 Feb 2001 22:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRCADUb>; Wed, 28 Feb 2001 22:20:31 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:22035 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129469AbRCADUW>;
	Wed, 28 Feb 2001 22:20:22 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103010316.f213G29209192@saturn.cs.uml.edu>
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Wed, 28 Feb 2001 22:16:02 -0500 (EST)
Cc: zam@namesys.com (Alexander Zarochentcev), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiser@namesys.com (Hans Reiser),
        reiserfs-dev@namesys.com
In-Reply-To: <20010228202733.A18073@caldera.de> from "Christoph Hellwig" at Feb 28, 2001 08:27:33 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> Urgg. limits.h is a userlevel header...
> 
> The attached patch will make similar atempts fail (but not this one as
> there is also a limits.h in gcc's include dir).

There are very few files needed from gcc's include dir. Linux ought to
be able to survive without them. Linux is already gcc-specific anyway.
