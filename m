Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbRESPTR>; Sat, 19 May 2001 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbRESPTI>; Sat, 19 May 2001 11:19:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51081 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261824AbRESPS4>;
	Sat, 19 May 2001 11:18:56 -0400
Date: Sat, 19 May 2001 11:18:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B068D00.95338099@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105191117580.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Abramo Bagnara wrote:

> Can't this easily avoided if the needed action is not
> 
> < /dev/zero/start_nuclear_war 
> or
> > /dev/zero/start_nuclear_war
> 
> but
> 
> echo "I'm evil" > /dev/zero/start_nuclear_war

Sure. And that's the right thing to do (not the implied action, that is -
_that_ would be too messy).

