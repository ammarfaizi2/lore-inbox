Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRAZONr>; Fri, 26 Jan 2001 09:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRAZONl>; Fri, 26 Jan 2001 09:13:41 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:13583 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130107AbRAZONX>; Fri, 26 Jan 2001 09:13:23 -0500
Date: Fri, 26 Jan 2001 15:12:15 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126151215.C6331@pcep-jamie.cern.ch>
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net> <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk> <14961.33191.626833.945221@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14961.33191.626833.945221@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 26, 2001 at 05:54:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> The connection failed, RST means connection reset.  RST means all
> state is corrupt and this connection must die.  It cannot be
> interpreted in any other way.

Therefore build a new connection, using a new source port if necessary.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
