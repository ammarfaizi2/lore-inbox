Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTDGTyI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTDGTyI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:54:08 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:15029 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S263612AbTDGTyH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 15:54:07 -0400
Date: Mon, 7 Apr 2003 16:05:33 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407200533.GA23680@ti19>
References: <20030407102005.4c13ed7f.manushkinvv@desnol.ru> <200304070709.h37792815083@mozart.cs.berkeley.edu> <20030407113534.1de8dc91.agri@desnol.ru> <b6s3k4$i0i$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6s3k4$i0i$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 07:57:08AM -0700, H. Peter Anvin wrote:
> Personally I would prefer if open() on
> /proc/*/fd would actually operate as if a dup() on the relevant file
> descriptor, which would be a significant change of semantics; however,
> one could argue those are the saner semantics.

We discussed this previously; I described the problems with
existing semantics, and on 2000/020/29 you wrote:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=fa.iqoa6kv.flii0q%40ifi.uio.no&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26q%3Dhpa%2Brugolsky%26btnG%3DGoogle%2BSearch

  "I'm hoping to fix this in 2.5.  The problem is that the way open() is
  done in the VFS *requires* the creation of a new filestructure."

I'm still open to suggestions. ;-)

Regards,

   Bill Rugolsky

