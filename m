Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTLVX3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTLVX3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:29:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45218 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264568AbTLVX3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:29:30 -0500
Message-ID: <3FE77E49.4010303@pobox.com>
Date: Mon, 22 Dec 2003 18:29:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <3FE7794D.7000908@pobox.com> <20031222232433.GT6438@matchmail.com>
In-Reply-To: <20031222232433.GT6438@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Mon, Dec 22, 2003 at 06:07:57PM -0500, Jeff Garzik wrote:
> 
>>would prefer to emphasize their differences.  A replacement for 
>>cryptoloop means you must support cryptoloop's on-disk format.
> 
> 
> Do you dislike the cryptoloop format?
> 
> What if you wanted to take a disk that was used with dm-crypt, and copy it
> to a file on a larger filesystem?  Would the data now be inaccessable
> because it's not in a format mountable by a loop driver?


Remember we are talking about two -totally different- drivers here.

I can't take my reiserfs data, copy it to a file on a larger filesystem, 
and then mount it with ext3.  And that's a good thing.

dm-crypt should not be constrained by cryptoloop, and vice versa.

	Jeff


