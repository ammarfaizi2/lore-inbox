Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268075AbTBRWjy>; Tue, 18 Feb 2003 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbTBRWjy>; Tue, 18 Feb 2003 17:39:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:36235 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268075AbTBRWjx>; Tue, 18 Feb 2003 17:39:53 -0500
Date: Tue, 18 Feb 2003 23:49:46 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] morse code panics for 2.5.62
Message-ID: <20030218224946.GB1048@louise.pinerecords.com>
References: <20030218135038.GA1048@louise.pinerecords.com> <20030218141757.GV351@lug-owl.de> <b2tl9c$48c$1@main.gmane.org> <20030218171247.GA351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218171247.GA351@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jbglaw@lug-owl.de]
> 
> Then, you can have
> const char morses[] = {
> 	MORSE2('A', '.', '-'),
> 	MORSE4('B', '-', '.', '.', '.'),
> 	MORSE4('C', '-', '.', '-', '.'),
> 	MORSE3('D', '-', '.', '.'),
> 	MORSE1('E', '.'),
> 	MORSE4('F', '.', '.', '-', '.')
> 	...
> };
> 
> That's going to take exactly the same memory in the compiled vmlinux
> image, *and* it's really readable:-) Of course, gcc will optimize any
> added "bloat" away...

Looks good to me, can you send an updated patch?

-- 
Tomas Szepe <szepe@pinerecords.com>
