Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbRGPBsp>; Sun, 15 Jul 2001 21:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRGPBsf>; Sun, 15 Jul 2001 21:48:35 -0400
Received: from 64.5.206.104 ([64.5.206.104]:4878 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S265771AbRGPBsY>; Sun, 15 Jul 2001 21:48:24 -0400
Date: Sun, 15 Jul 2001 21:48:21 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <volodya@mindspring.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, <reiser@namesys.com>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.LNX.4.20.0107152104290.1295-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0107152139440.17437-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001 volodya@mindspring.com wrote:

> May I ask where does one get a patched fileutils package ? I have just
> downloaded fileutils-4.1 from prep.ai.mit.edu and it has 0 information in
> README, configure --help, etc on how to enable this and when compiled ls
> still complains.
>
>                    thanks !
>
>                             Vladimir Dergachev

The actual instructions are in the glibc documentation, in the section about
file position. If I'm reading this correctly, you have to define
_FILE_OFFSET_BITS to be 64, then the large file functions should overlay the
regular ones transparently, but YMMV.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>




