Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTFGXlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTFGXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:41:52 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:53908 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S264029AbTFGXlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:41:51 -0400
Date: Sun, 8 Jun 2003 01:59:03 +0100 (BST)
From: James Stevenson <james@stev.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: ncorbic@sangoma.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wanrouter: fix stack usage
In-Reply-To: <20030607234510.GB8511@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0306080158280.1776-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

i am guessing it doesnt compile.

int err;
err -ENOBUFS; ????


-                       return -ENOBUFS;
+                       err -ENOBUFS;
+                       goto out;


On Sun, 8 Jun 2003, Jörn Engel wrote:

> Hi!
> 
> Another stack patch that grew old until it didn't apply anymore.  Any
> reasons why it has been ignore so far?
> 
> Jörn
> 
> 

