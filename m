Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUBYUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUBYUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:22:26 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:39572 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261304AbUBYUWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:22:25 -0500
Date: Wed, 25 Feb 2004 15:12:16 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225201216.GA6799@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <20040225181540.GB8983@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225181540.GB8983@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 07:15:40PM +0100, Christophe Saout wrote:
> Ok, here it is. Still working (when not using omac or hmac) after
> fixing the compile problems (see other mail).
> 
> If this is ok someone should split out the scatterwalk_* move from
> your patch and submit it and this one to Andrew so that dm-crypt
> doesn't go boom on highmem machines.

Great thanks a bunch.

Here is the scatterlist+"Le Patch de Christophe":
  http://jlcooke.ca/lkml/cryptowalk_christophe_25feb2004.patch

Reguarding dm-crypt:
 I didn't get a response back when suggesting we store IV and MAC info for
 each block.  Can we do this?  Can I do this?  Where's the source, in
 2.3.6-main?  I'd like to implement this IV and optional OMAC stuff for
 encrypted filesyetems (I assume that's that dm-crypt is replacing)

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
