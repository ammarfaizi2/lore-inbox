Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQKETij>; Sun, 5 Nov 2000 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQKETia>; Sun, 5 Nov 2000 14:38:30 -0500
Received: from adsl-63-200-41-38.steelrain.org ([63.200.41.38]:13300 "EHLO
	vaio.thor.sbay.org") by vger.kernel.org with ESMTP
	id <S129431AbQKETiW>; Sun, 5 Nov 2000 14:38:22 -0500
Date: Sun, 5 Nov 2000 11:37:59 -0800 (PST)
From: Dave Zarzycki <dave@thor.sbay.org>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: taskfs and kernfs
In-Reply-To: <Pine.GSO.4.21.0011051213570.25503-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011050934080.1045-100000@vaio.thor.sbay.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Alexander Viro wrote:

> However, kernfs is _not_ procfs \setminus procfs-proper. It's our current
> /proc/sys.

Okay. I didn't realize that's what you had in mind when you wrote
"kernfs." Mind if I ask why you didn't call it "sysctlfs" or "sysfs?"

In you earlier e-mail, you suggested that sysctl(2) would use path_walk().
Would that mean that your kernfs would have to be loaded into the kernel
and mounted for sysctl(2) to work? Or am I missing something obvious?

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/









-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
