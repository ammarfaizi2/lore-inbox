Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284853AbRLEXqs>; Wed, 5 Dec 2001 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284855AbRLEXqj>; Wed, 5 Dec 2001 18:46:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:56068 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284851AbRLEXqT>;
	Wed, 5 Dec 2001 18:46:19 -0500
Subject: Re: [FS] Why doesn't this patch work?
From: Robert Love <rml@tech9.net>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20011205152834.A11289@netnation.com>
In-Reply-To: <20011205152834.A11289@netnation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 18:46:21 -0500
Message-Id: <1007595982.848.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 18:28, Simon Kirby wrote:
> I'm attempting to write this little dinky patch to see who calls fsync()
> or fdatasync(), but it's spitting out compiler warnings.  I can't figure
> out why, though.  What did I do wrong?
> 
> buffer.c: In function `report_culprit':
> buffer.c:409: warning: assignment from incompatible pointer type
> buffer.c:410: warning: passing arg 2 of `d_path' from incompatible pointer type
> buffer.c:420: warning: passing arg 1 of `mntput' from incompatible pointer type

s/struct vfsmnt/struct vfsmount/

	Robert Love

