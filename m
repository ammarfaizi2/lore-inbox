Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUIARvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUIARvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIARvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:51:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:65211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267394AbUIARse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:48:34 -0400
Date: Wed, 1 Sep 2004 10:48:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [1/7] make do_each_task_pid()/while_each_task_pid() typecheck
In-Reply-To: <20040901172710.GE5492@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0409011046450.2295@ppc970.osdl.org>
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com>
 <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Heh. These improvements look fine, but I definitely don't want to first 
apply the broken one and then improve upon it - it would be much nicer to 
get this kind of nice "progression" patch that starts off from a clean 
thing and just improves on it (maybe that ends up meaning just one patch 
to replace Kirill's, I don't know..)

		Linus
