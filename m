Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTBDTjm>; Tue, 4 Feb 2003 14:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTBDTjm>; Tue, 4 Feb 2003 14:39:42 -0500
Received: from relay02.roc.frontiernet.net ([66.133.131.35]:10410 "EHLO
	relay02.roc.frontiernet.net") by vger.kernel.org with ESMTP
	id <S267434AbTBDTjk>; Tue, 4 Feb 2003 14:39:40 -0500
Date: Tue, 4 Feb 2003 14:50:20 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS question
Message-ID: <20030204145020.A23244@newbox.localdomain>
References: <Pine.LNX.4.21.0302041038120.8655-100000@source.intac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0302041038120.8655-100000@source.intac.net>; from kernellist@source.intac.net on Tue, Feb 04, 2003 at 10:51:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernellist@source.intac.net on Tue  4/02 10:51 -0500:
> I have quite a few servers running kernel 2.4.18. I need to replace an
> nfs server that all my linux clients mount, and I want to know if
> there is a way for me to do this without having to umount and remount
> everything.

I *think* it will work if you keep major, minor, and inode numbers on
the new server the same for anything clients have mounted.  These are
used to construct the cookies handed to clients.
