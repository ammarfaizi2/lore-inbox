Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTHOO4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 10:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTHOO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 10:56:10 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:57604 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263894AbTHOO4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 10:56:08 -0400
Subject: Re: 2.6.0test3mm2oops in mm/filemap:1930
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0308151537300.20496@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308151537300.20496@hosting.rdsbv.ro>
Content-Type: text/plain
Message-Id: <1060959361.744.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 16:56:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 14:39, Catalin BOIE wrote:

> kernel BUG at mm/filemap.c:1930!

Please, edit file mm/filemap.c and delete the line #1930. It's a BUG_ON
directive which can be safely ignored. Then, recompile.

