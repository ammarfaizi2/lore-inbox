Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312093AbSCTTxq>; Wed, 20 Mar 2002 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312095AbSCTTxg>; Wed, 20 Mar 2002 14:53:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27918 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312093AbSCTTxa>; Wed, 20 Mar 2002 14:53:30 -0500
Date: Wed, 20 Mar 2002 19:56:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et
 al
In-Reply-To: <127930000.1016651345@flay>
Message-ID: <Pine.LNX.4.21.0203201950450.1587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin J. Bligh wrote:
> This u-k-space would be a good area for at least two things (and probably others):
> 1. A good place to put the process pagetables. ....
> 2. A good place to make a per-task kmap area. ....

I'm unsure about it, but I do think it's an idea worth pursuing (in 2.5).
Rik seems to be suggesting the same in your "Scalability problem" thread.

Hugh

