Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130988AbRBWKS4>; Fri, 23 Feb 2001 05:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131133AbRBWKSr>; Fri, 23 Feb 2001 05:18:47 -0500
Received: from mx.interplus.ro ([193.231.252.3]:50183 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S130988AbRBWKSj>;
	Fri, 23 Feb 2001 05:18:39 -0500
Message-ID: <3A963909.7A72B28@interplus.ro>
Date: Fri, 23 Feb 2001 12:18:49 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac10 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: lk <linux-kernel@vger.kernel.org>
Subject: Buglet: Mount iso-9660 always have exec bit set (755)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	For a while I'm annoyed by a buglet:

When trying to mount an ordinary CD like (as root):

mount /dev/cdrom /mnt/cdrom -o ro,noexec

it works, but all files have the execute attribute set for all users,
and that is annoying in 

MidnightCommander and other filemanagers that try execute the file as a
program instead of opening it based on file asociation set.

Mount version is: mount-2.10o 
kernel2.4.1ac10 but see the same behaviour on all 2.4.x kernels.

	Is that something that I miss or is a small buglet in mounting isofs
???

		Thank you 

		Mircea C.

P.S: That problem didn't arise when using 2.2.x.
