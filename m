Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTLVX1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTLVX1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:27:14 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:31167 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264563AbTLVX1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:27:12 -0500
Date: Mon, 22 Dec 2003 15:24:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031222232433.GT6438@matchmail.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Fruhwirth Clemens <clemens@endorphin.org>,
	Joe Thornber <thornber@sistina.com>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <3FE7794D.7000908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE7794D.7000908@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 06:07:57PM -0500, Jeff Garzik wrote:
> would prefer to emphasize their differences.  A replacement for 
> cryptoloop means you must support cryptoloop's on-disk format.

Do you dislike the cryptoloop format?

What if you wanted to take a disk that was used with dm-crypt, and copy it
to a file on a larger filesystem?  Would the data now be inaccessable
because it's not in a format mountable by a loop driver?
