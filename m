Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUC0Nd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUC0Nd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 08:33:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:17042 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261712AbUC0Nd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 08:33:56 -0500
Date: Sat, 27 Mar 2004 13:31:33 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Williams <peterw@aurema.com>
Cc: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040327133133.GB21884@mail.shareable.org>
References: <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com> <20040325174053.GB11236@mail.shareable.org> <406369A1.7090905@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406369A1.7090905@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Making HZ == USER_HZ would also solve the problem.

They were equal once.

Making them equal now would reintroduce the problem that USER_HZ was
created to resolve: some userspace programs hard-code the value, so it
cannot be changed in interfaces used by those programs.

-- Jamie
