Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbSJGJJw>; Mon, 7 Oct 2002 05:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262973AbSJGJJv>; Mon, 7 Oct 2002 05:09:51 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:54280 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S262972AbSJGJJv>; Mon, 7 Oct 2002 05:09:51 -0400
Date: Mon, 7 Oct 2002 19:15:03 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Balazs Scheidler <bazsi@balabit.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unix domain sockets bugfix
In-Reply-To: <20021007073532.GA15799@balabit.hu>
Message-ID: <Mutt.LNX.4.44.0210071911300.2828-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Balazs Scheidler wrote:

> I've found a bug with unix domain sockets in both kernels 2.2 and 2.4.

This is not an issue for 2.2, as msg->msg_namelen is already zeroed
appropriately.


- James
-- 
James Morris
<jmorris@intercode.com.au>


