Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbREXV1U>; Thu, 24 May 2001 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbREXV1L>; Thu, 24 May 2001 17:27:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60583 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262334AbREXV1C>;
	Thu, 24 May 2001 17:27:02 -0400
Date: Thu, 24 May 2001 17:26:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B0D763C.26991788@gmx.de>
Message-ID: <Pine.GSO.4.21.0105241724430.24073-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Edgar Toernig wrote:

> > What *won't* happen is, you won't get side effects from opening
> > your serial ports (you'd have to open them without O_DIRECTORY
> > to get that) so that seems like a little step forward.
> 
> As already said: depending on O_DIRECTORY breaks POSIX compliance
> and that alone should kill this idea...

What really kills that idea is the fact that you can trick applications
into opening your serial ports _without_ O_DIRECTORY.

