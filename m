Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbRGHSbt>; Sun, 8 Jul 2001 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbRGHSbj>; Sun, 8 Jul 2001 14:31:39 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:21122 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266959AbRGHSbW>;
	Sun, 8 Jul 2001 14:31:22 -0400
Date: Mon, 9 Jul 2001 06:31:11 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Adam <adam@cfar.umd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recvfrom and sockaddr_in.sin_port
Message-ID: <20010709063111.A28940@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107081338140.936-100000@eax.student.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107081338140.936-100000@eax.student.umd.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 01:42:28PM -0500, Adam wrote:

    so it seem to imply that only tcp packets only are to be passed.
    still group "SOCK_RAW" is subset of the PF_INET group (the way
    I see it), so from ip(7) man page I should use sockaddr_in
    structure, which should be defined in this particular case,
    as it ought be for IPPROTO_UDP.

have you dumped the packet contents? presumably its a raw packet,
protocol 6, and the header and such like is returned

i see no reason, for raw packets to fill out sin_port whatoever, it
just doesn't make sense that raw packets have a port



  --cw



