Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269848AbUJHLYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269848AbUJHLYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269845AbUJHLX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:23:59 -0400
Received: from holomorphy.com ([207.189.100.168]:9942 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269842AbUJHLXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:23:32 -0400
Date: Fri, 8 Oct 2004 04:23:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041008112322.GG9106@holomorphy.com>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org> <20041007114040.GV9106@holomorphy.com> <1097184341l.10532l.0l@werewolf.able.es> <1097185597l.10532l.1l@werewolf.able.es> <20041007150708.5d60e1c3.akpm@osdl.org> <1097188883l.6408l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097188883l.6408l.1l@werewolf.able.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.10.08, Andrew Morton wrote: "J.A. Magallon" <jamagallon@able.es> wrote:
>> Yes, there seems to be a mingo/wli bunfight over prof_cpu_mask.
>> Something like this, I think:

On Thu, Oct 07, 2004 at 10:41:23PM +0000, J.A. Magallon wrote:
> Thanks, that made it work again !!
> Total set of patches to boot:
> - your latest fix
> - revert optimize profile + Andi's patch
> - uhci fix (still needed ?)
> - e100 fix (only thing I have seen at the moment...)
> - 1Gb lowmem
> How about including the last one in -mm, for testing ? I use it in a server
> and in my home workstation and it works fine (even with nvidia drivers ;) ).
> Everything attached (they are really small...)

Would have been nice if you had tried my replacement since you went so
far as to cc: me on its post, the primary reason being I expect it to
have an actual observable effect toward the end the patches are supposed
to have, though if whoever wants it insists, they can do it their own
way; I merely expect the internal function call bits to be ineffective.

-- wli
