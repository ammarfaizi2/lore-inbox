Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265630AbUA0WP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbUA0WP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:15:58 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:46244 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S265630AbUA0WPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:15:55 -0500
Date: Tue, 27 Jan 2004 17:12:29 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
Message-ID: <20040127221229.GA16413@certainkey.com>
References: <20040127193945.GA15559@certainkey.com> <Xine.LNX.4.44.0401271514150.4185-100000@thoron.boston.redhat.com> <20040127202225.GA15808@certainkey.com> <20040127130504.1c760026.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127130504.1c760026.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated the faster_sha2.c to include a quick performance test, same URL.

The Ch/sec and Maj/sec can't be easily compared, however instruction
count can to some extent.

http://jlcooke.ca/lkml/faster_sha2_x86.s
http://jlcooke.ca/lkml/faster_sha2_ppc.s
http://jlcooke.ca/lkml/faster_sha2_alpha.s
http://jlcooke.ca/lkml/faster_sha2_sparc.s

Hope this helps, I'll know better next time I ask for patch-blessing.  :)

JLC


On Tue, Jan 27, 2004 at 01:05:04PM -0800, David S. Miller wrote:
> On Tue, 27 Jan 2004 15:22:25 -0500
> Jean-Luc Cooke <jlcooke@certainkey.com> wrote:
> 
> > The Ch() and Maj() operations are used a lot in sha256/512.
> 
> Your analysis is great, but James was really asking for numbers :-)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
