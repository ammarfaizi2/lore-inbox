Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272183AbRHXPuW>; Fri, 24 Aug 2001 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272189AbRHXPuM>; Fri, 24 Aug 2001 11:50:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2954 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272157AbRHXPuC>;
	Fri, 24 Aug 2001 11:50:02 -0400
Date: Fri, 24 Aug 2001 11:50:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Widmer <cwidmer@iiic.ethz.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: creating new directories under /proc
In-Reply-To: <200108241508.f7OF89k14834@mail.swissonline.ch>
Message-ID: <Pine.GSO.4.21.0108241149590.18144-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Christian Widmer wrote:

> to create a new file in the proc file system i can use 
> create_proc_read_entry("/proc/driver/my_new_file", 0, 0, my_proc, 0)
> 
> but what if i want to register my_new_file under a directory
> /proc/driver/my_driver_dir/. how do i create a new directory under
> the proc tree?

proc_mkdir()

