Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbREEPiK>; Sat, 5 May 2001 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbREEPiB>; Sat, 5 May 2001 11:38:01 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:46096 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S132825AbREEPht>; Sat, 5 May 2001 11:37:49 -0400
Date: Sun, 6 May 2001 03:37:46 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Peter Rival <frival@zk3.dec.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010506033746.A30690@metastasis.f00f.org>
In-Reply-To: <20010505063726.A32232@va.samba.org> <3AF4118F.330C3E86@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF4118F.330C3E86@zk3.dec.com>; from frival@zk3.dec.com on Sat, May 05, 2001 at 10:43:27AM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 10:43:27AM -0400, Peter Rival wrote:

    Has anyone looked into memory hot swap/hot add support? 

Adding memory probably isn't going to be too hard... but taking
existing memory off line is tricky. You have to find some way of
finding all the pages that are in use and then dealing with them
appropriately, and when some are locked or contain kernel data this
would be extremely difficult I should think.

    Especially with systems with Chipkill coming out, this would be
    great to support...

Chipkill?


  --cw
