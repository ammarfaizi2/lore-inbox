Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVG1AEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVG1AEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVG1AEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 20:04:47 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:51123 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261175AbVG1AEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 20:04:46 -0400
From: Grant Coady <lkml@dodo.com.au>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Clayton Weaver" <cgweav@fastmail.fm>, <linux-kernel@vger.kernel.org>
Subject: Re: xor as a lazy comparison
Date: Thu, 28 Jul 2005 10:04:40 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <k28ge1dg9mlad9mbp09oqshnspmijhf6hb@4ax.com>
References: <1122488682.7051.239374398@webmail.messagingengine.com> <Pine.LNX.4.61.0507271547580.7346@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507271547580.7346@chaos.analogic.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 15:58:48 -0400, "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
>
>I think the XOR thread was started by somebody as a ruse or
>a joke. XOR will always destroy the value of an operand. 

You missed the part where somebody checked assembler output and
found compiler optimised xor to cmp as nothing referenced the result.

Grant.

