Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVEERiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVEERiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 13:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVEERiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 13:38:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:55312 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262118AbVEERiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 13:38:06 -0400
Message-ID: <427A59BC.1020208@shadowen.org>
Date: Thu, 05 May 2005 18:37:00 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
CC: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com
Subject: Re: [3/3] sparsemem memory model for ppc64
References: <E1DTQWH-0002We-I9@pinky.shadowen.org> <20050505023132.GB20283@austin.ibm.com>
In-Reply-To: <20050505023132.GB20283@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> Hi,
> 
> Just two formatting nitpicks below.

Thanks, this would be better served by rewriting the first comment and
removing the second all together.

/* Add all physical memory to the bootmem map, mark each area
 * present.  The first block has already been marked present above.
 */

I note that the diff in question has sneaked into the wrong patch, that
segement represents memory_present.  So I'll rediff them with it there.
 No overall change to the code.

-apw
