Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJZSxY>; Sat, 26 Oct 2002 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJZSxX>; Sat, 26 Oct 2002 14:53:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23700 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261434AbSJZSxX>;
	Sat, 26 Oct 2002 14:53:23 -0400
Date: Sat, 26 Oct 2002 14:59:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Steinmetz <ast@domdv.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
In-Reply-To: <3DBAE4A0.4090802@domdv.de>
Message-ID: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2002, Andreas Steinmetz wrote:

> Maybe I do oversee the obious but:
> 
> can somebody please explain why rootfs is exposed in /proc/mounts (I do 
> mean the "rootfs / rootfs rw 0 0" entry) and if there is a good reason 
> for the exposure?

Mostly the fact that it _is_ mounted and special-casing its removal from
/proc/mounts is more PITA than it's worth.

