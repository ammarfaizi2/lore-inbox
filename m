Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSLHCAt>; Sat, 7 Dec 2002 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSLHCAt>; Sat, 7 Dec 2002 21:00:49 -0500
Received: from www.security.wayne.edu ([141.217.2.10]:5505 "EHLO
	security.wayne.edu") by vger.kernel.org with ESMTP
	id <S265096AbSLHCAs>; Sat, 7 Dec 2002 21:00:48 -0500
Date: Sat, 7 Dec 2002 21:08:27 -0500
From: "Nathan W. Labadie" <ab0781@wayne.edu>
To: linux-kernel@vger.kernel.org
Subject: problems mounting root partition with 2.5.48+ kernels
Message-ID: <20021208020827.GA9607@security.wayne.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-gpg-key: http://security.wayne.edu/keys/nathan_labadie.key
X-gpg-fingerprint: FB19 5F58 9CF2 8E8C E221 5603 9D75 0FB3 06C0 1952
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bugzilla report can be found here:
http://bugme.osdl.org/show_bug.cgi?id=130

I have both bzImage-2.5.47 and bzImage-2.5.50 sitting in /boot, both
compiled with the same kernel config. 2.5.47 boots and successfully
mounts root without any problems. 2.5.50 boots, but errors out with
'can't mount root device'. I've tried this with both XFS and ReiserFS as
my root filesystem, so I'm guessing it's not filesystem specific. I had
the same problem with 2.5.48 and 2.5.49. Both grub and modutils are at
the current version.

/dev/hda5 swap
/dev/hda6 /boot
/dev/hda7 /

Any help would be greatly appreciated.

NOTE: I'm not on the list so please CC me on the reply.

Thanks much,
Nate

-- 
Nathan W. Labadie       | ab0781@wayne.edu	
Sr. Security Specialist | 313-577-2126
Wayne State University  | 313-577-1338 fax
C&IT Information Security Office: http://security.wayne.edu
