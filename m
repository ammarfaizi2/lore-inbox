Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263482AbTCNT61>; Fri, 14 Mar 2003 14:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263483AbTCNT61>; Fri, 14 Mar 2003 14:58:27 -0500
Received: from holomorphy.com ([66.224.33.161]:3278 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263482AbTCNT6Z>;
	Fri, 14 Mar 2003 14:58:25 -0500
Date: Fri, 14 Mar 2003 12:08:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <20030314200857.GL20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
	linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303131955.27060.gregory@castandcrew.com> <20030314041307.GK20188@holomorphy.com> <200303140931.15541.gregory@castandcrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303140931.15541.gregory@castandcrew.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 20:13, William Lee Irwin III wrote:
>> Hmm, neither slabinfo nor meminfo show the machine being under any
>> stress. Were they generated while the problem was happening?
>> The useful information would be to collect meminfo and slabinfo while
>> kswapd and updated are spinning. Also, cpuinfo doesn't ever change,
>> (at least while being run on the same box) so you can leave that out.

On Fri, Mar 14, 2003 at 09:31:15AM -0800, Gregory K. Ruiz-Ade wrote:
> Ahh.  I was a bit out of it yesterday, and didn't think to actually stress 
> the machine. :\
> I'll be able to give it a good beating this weekend sometime.

cc: me when you post those results.


On Thursday 13 March 2003 20:13, William Lee Irwin III wrote:
>> BTW, oopses tracing back into the VM doesn't help. It's usually someone
>> doing something wrong the VM checks for. In this case I'll bet someone
>> (i.e. LVM) called vmalloc() with interrupts off.

On Fri, Mar 14, 2003 at 09:31:15AM -0800, Gregory K. Ruiz-Ade wrote:
> Hmm... Okay, mind if I quote you when I post that oops the the lvm list? :)

Understand that was said in the context of finding the VM bug. I'm not
interested in LVM bugs, legitimate though they may be, mostly b/c it's
not my project and I can't save the world.


-- wli
