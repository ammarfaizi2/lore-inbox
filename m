Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUJHDlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUJHDlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUJHDlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:41:03 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:43690
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266116AbUJHDk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:40:59 -0400
Date: Thu, 7 Oct 2004 20:39:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: cfriesen@nortelnetworks.com, martijn@entmoot.nl, hzhong@cisco.com,
       jst1@email.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007203943.24560c33.davem@davemloft.net>
In-Reply-To: <20041008025148.GA724@mark.mielke.cc>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<4165C20D.8020808@nortelnetworks.com>
	<20041007152634.5374a774.davem@davemloft.net>
	<4165C58A.9030803@nortelnetworks.com>
	<20041007154204.44e71da6.davem@davemloft.net>
	<20041008025148.GA724@mark.mielke.cc>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 22:51:48 -0400
Mark Mielke <mark@mark.mielke.cc> wrote:

> Your position, I believe has been that the use of select() on a blocking
> file descriptor is invalid.

Incorrect.

My position is that expecting a blocking file descriptor not to
block is invalid.
