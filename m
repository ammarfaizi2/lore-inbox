Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVHRPcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVHRPcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHRPcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:32:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23009 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932257AbVHRPcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:32:10 -0400
Message-ID: <4304A9F5.2070004@sgi.com>
Date: Thu, 18 Aug 2005 10:32:05 -0500
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xfs-masters@oss.sgi.com
CC: Jesper Juhl <jesper.juhl@gmail.com>, nathans@sgi.com,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [PATCH] pull XFS support out of Kconfig submenu
References: <200508172245.49043.jesper.juhl@gmail.com> <20050818135356.GA16845@taniwha.stupidest.org> <4304A7D6.3000307@sgi.com>
In-Reply-To: <4304A7D6.3000307@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> I have no problem with removing the submenu.

Hm, however, if this is a purely cosmetic thing, let's go all the way 
and format the xfs options like the others, with indentation etc:

  config XFS_RT
-       bool "Realtime support (EXPERIMENTAL)"
+       bool "  XFS Realtime support (EXPERIMENTAL)"


May be simpler to just make this change internally & let Nathan push it 
out.  I do agree that it looks better.  :)

-Eric
