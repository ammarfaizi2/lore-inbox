Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUIPJLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUIPJLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUIPJLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:11:31 -0400
Received: from colin2.muc.de ([193.149.48.15]:55815 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267864AbUIPJL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:11:29 -0400
Date: 16 Sep 2004 11:11:28 +0200
Date: Thu, 16 Sep 2004 11:11:28 +0200
From: Andi Kleen <ak@muc.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916091128.GA55409@muc.de>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com> <20040916100419.A31029@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916100419.A31029@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IOW, think from a tasks point of view.  It gets into the scheduler,
> and switch_to() is just a normal function which just happens to sleep
> for some time.

On x86/x86-64 the stack switch is inlined into schedule() 

-Andi
