Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132786AbRAZP7Q>; Fri, 26 Jan 2001 10:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132924AbRAZP7G>; Fri, 26 Jan 2001 10:59:06 -0500
Received: from home162.liacs.nl ([132.229.210.162]:15876 "EHLO
	fog.mors.wiggy.net") by vger.kernel.org with ESMTP
	id <S132872AbRAZP7B>; Fri, 26 Jan 2001 10:59:01 -0500
Date: Fri, 26 Jan 2001 16:21:29 +0100
From: Wichert Akkerman <wichert@valinux.com>
To: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: the remount problem [2.4.0] kind of solved [patch]
Message-ID: <20010126162129.J5539@cistron.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-devel@lists.debian.org
In-Reply-To: <20010121130745.A1383@lina.inka.de> <87snmcl31k.fsf@mose.informatik.uni-tuebingen.de> <20010122093234.A9194@lina.inka.de> <87vgr78t6f.fsf@mose.informatik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87vgr78t6f.fsf@mose.informatik.uni-tuebingen.de>; from goswin.brederlow@student.uni-tuebingen.de on Mon, Jan 22, 2001 at 05:09:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Goswin Brederlow wrote:
> Maybe the kernel coud swap in the deleted libraries and keep it in
> memory or real swap from then on instead of blocking the fs.

No, you have no idea how large the file might grow and you need to
keep that data somewhere.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
