Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUCaAPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUCaAPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:15:36 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262258AbUCaAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:15:35 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Date: Tue, 30 Mar 2004 16:14:24 -0800
User-Agent: KMail/1.6.1
Cc: Ray Bryant <raybry@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com, akpm@osdl.org,
       John Hawkes <hawkes@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com> <20040330101952.GN791@holomorphy.com> <406A0DED.8090906@sgi.com>
In-Reply-To: <406A0DED.8090906@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403301614.24865.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 4:16 pm, Ray Bryant wrote:
> So, assuming all of the above is correct, I guess I am willing to remove
> the call by reference requirement that I was harping on so much last
> summer.
>
> Jesse do you agree?

Yeah, that's fine by me.  Given what I've seen, it doesn't look like the 
bitmap manipulation routines need to be particularly speedy--certainly not 
for sn2 specific code, so I'm ok with just about any implementation so long 
as it supports >64p and >64 nodes.

Thanks,
Jesse
