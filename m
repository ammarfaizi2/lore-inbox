Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRBHEAL>; Wed, 7 Feb 2001 23:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRBHEAC>; Wed, 7 Feb 2001 23:00:02 -0500
Received: from sfo-gw.covalent.net ([207.44.198.62]:7033 "EHLO hand.dotat.at")
	by vger.kernel.org with ESMTP id <S129694AbRBHD7l>;
	Wed, 7 Feb 2001 22:59:41 -0500
Date: Thu, 8 Feb 2001 03:58:03 +0000
From: Tony Finch <dot@dotat.at>
To: Dan Kegel <dank@alumni.caltech.edu>
Cc: kuznet@ms2.inr.ac.ru,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Finch <dot@dotat.at>
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
Message-ID: <20010208035803.L74296@hand.dotat.at>
In-Reply-To: <3A81F60C.7C1DB09A@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A81F60C.7C1DB09A@alumni.caltech.edu>
Organization: Covalent Technologies, Inc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@alumni.caltech.edu> wrote:
>
>Tony, are people using the TCP_NOPUSH define as a way to detect
>the presence of T/TCP support?

No, MSG_EOF is the right way to do that.

Tony.
-- 
f.a.n.finch    fanf@covalent.net    dot@dotat.at
FAIR ISLE: WESTERLY VEERING NORTHERLY 4 OR 5. WINTRY SHOWERS. MAINLY GOOD.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
