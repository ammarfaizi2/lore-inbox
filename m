Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSCRWsk>; Mon, 18 Mar 2002 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSCRWsb>; Mon, 18 Mar 2002 17:48:31 -0500
Received: from ns.hobby.nl ([212.72.224.8]:36868 "EHLO hgatenl.hobby.nl")
	by vger.kernel.org with ESMTP id <S293201AbSCRWsW>;
	Mon, 18 Mar 2002 17:48:22 -0500
Date: Mon, 18 Mar 2002 22:23:05 +0100
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020318222305.A23934@vdpas.hobby.nl>
In-Reply-To: <20020318025233.A7C044E534@mail.vnsecurity.net> <E16mvYx-0004re-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 11:44:27AM +0000, Alan Cox wrote:
> > - 2.4.19-pre-ac: kswapd try to swap out and access disk continuously. Whole
> > system is slow down and un-interactivable.
> 
> echo "2" >/proc/sys/vm/overcommit_memory

Why are you using the value "2"?
It makes me think that it activates some special magic,
but all I can find in mmap.c is:

        /* Sometimes we want to use more memory than we have. */
        if (sysctl_overcommit_memory)
            return 1;

Regards,
Toon.
-- 
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
