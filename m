Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUJFWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUJFWgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269584AbUJFWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:33:52 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39579
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269419AbUJFWaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:30:01 -0400
Date: Wed, 6 Oct 2004 15:29:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: cfriesen@nortelnetworks.com, hzhong@cisco.com, aebr@win.tue.nl,
       joris@eljakim.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006152908.2770b14f.davem@davemloft.net>
In-Reply-To: <20041006203818.GD4523@pclin040.win.tue.nl>
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
	<41644D86.4010500@nortelnetworks.com>
	<20041006130615.4f65a920.davem@davemloft.net>
	<4164530F.7020605@nortelnetworks.com>
	<20041006203818.GD4523@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 22:38:18 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> On Wed, Oct 06, 2004 at 02:18:23PM -0600, Chris Friesen wrote:
> 
> > In any case, the current behaviour is not compliant with the POSIX text 
> > that Andries posted.  Perhaps this should be documented somewhere?
> 
> For the time being I wrote (in select.2)
> 
> BUGS
>        It has been reported (Linux 2.6) that select may report  a

2.4.x has identical behavior
