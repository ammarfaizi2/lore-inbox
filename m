Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131559AbRAZOqf>; Fri, 26 Jan 2001 09:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbRAZOqZ>; Fri, 26 Jan 2001 09:46:25 -0500
Received: from gate.in-addr.de ([212.8.193.158]:30984 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S131559AbRAZOqN>;
	Fri, 26 Jan 2001 09:46:13 -0500
Date: Fri, 26 Jan 2001 15:46:13 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:  hotmail not dealing with ECN
Message-ID: <20010126154613.M3849@marowsky-bree.de>
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net> <Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk> <14961.25754.449497.640325@pizda.ninka.net> <20010126151058.A6331@pcep-jamie.cern.ch> <14961.35880.887884.1405@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <14961.35880.887884.1405@pizda.ninka.net>; from "David S. Miller" on 2001-01-26T06:39:36
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-26T06:39:36,
   "David S. Miller" <davem@redhat.com> said:

> The RST frame does not indicate why it happened, so you may not intuit
> the reason, "retry" the connection, or anything else like that.  It
> means connection failed, and we must return error from connect().
> 
> Nothing else is acceptable.

That would mean that the people worried about this should write a
wrapper-library for the connect() call, and maybe add a no_ecn flag to a
socket, and leave the kernel alone.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
