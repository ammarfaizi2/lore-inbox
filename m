Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTCNBnQ>; Thu, 13 Mar 2003 20:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263229AbTCNBnQ>; Thu, 13 Mar 2003 20:43:16 -0500
Received: from holomorphy.com ([66.224.33.161]:31688 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263228AbTCNBnQ>;
	Thu, 13 Mar 2003 20:43:16 -0500
Date: Thu, 13 Mar 2003 17:53:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <20030314015346.GJ20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
	linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <20030314004256.GI20188@holomorphy.com> <200303131745.28683.gregory@castandcrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131745.28683.gregory@castandcrew.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 16:42, William Lee Irwin III wrote:
>> Hmm, slabinfo would be very helpful, as well as meminfo.

On Thu, Mar 13, 2003 at 05:45:28PM -0800, Gregory K. Ruiz-Ade wrote:
> I'll have to schedule a reboot into that kernel, but I'll try to get it 
> tonight if at all possible.

That's fine; I'm not in a hurry. =)


On Thursday 13 March 2003 16:42, William Lee Irwin III wrote:
>> You might need bh stuff (memclass-related or something like it) if it's
>> general disk io. Can't be too sure until slabinfo + meminfo materialize.

On Thu, Mar 13, 2003 at 05:45:28PM -0800, Gregory K. Ruiz-Ade wrote:
> I'm not familiar with "bh"... where can I read up on what it is?

bh == buffer_head. fs/buffer_head.c has the code.


-- wli
