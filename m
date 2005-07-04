Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVGDUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVGDUUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVGDUUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:20:39 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:1669 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261598AbVGDUUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:20:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bvcJ3bBtWb9Z2VNVow7dg40D3dEfv6wlwS8/FrcfX02Vu1466SoBOfWHzR6Y0eYQx7/MdvcgHKfqoeO91sxkpTtktfAz1OQ3g5uxpCEl4FSpAVQAjEqnFptgnzHvRAG4VllJe0fbtfz6I3DN54wJoj3S0rV0/BvKfaEaRFy5NQI=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.13-rc1-mm1
Date: Tue, 5 Jul 2005 00:27:07 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl>
In-Reply-To: <200507020005.04947.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507050027.08731.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 July 2005 02:05, Rafael J. Wysocki wrote:
> I get this errors on a dual-Opteron box (64-bit):

> ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 16, size 512)
> ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 128, size 512)
> EXT3-fs: unable to read superblock
> EXT2-fs: unable to read superblock
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,19)

I've filed a bug at kernel bugzilla so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4841

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
