Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbSJPQRB>; Wed, 16 Oct 2002 12:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbSJPQRA>; Wed, 16 Oct 2002 12:17:00 -0400
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:24279 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S265128AbSJPQRA>; Wed, 16 Oct 2002 12:17:00 -0400
Date: Wed, 16 Oct 2002 18:22:14 +0200 (CEST)
From: Bosko Radivojevic <bole@etf.bg.ac.yu>
To: Stefan Schwandter <swan@shockfrosted.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
In-Reply-To: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
Message-ID: <Pine.LNX.4.44.0210161820100.29607-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Stefan Schwandter wrote:

> I saw capabilities and acl patches for ext2/3 enter -mm. Is it possible
> now to give an executable (that lives on an ext2/ext3 fs) the necessary
> rights to use SCHED_FIFO without being setuid root? Could someone give
> me some pointers for these topics (capabilities support in linux, acl)?

The program needs CAP_SYS_NICE capability. Look at http://www.linsec.org
or http://www.lids.org

Greetings


