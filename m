Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTJKOsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTJKOsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:48:37 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:48867 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S263316AbTJKOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:48:36 -0400
Date: Sat, 11 Oct 2003 09:48:08 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Atul Mukker <Atul.Mukker@lsil.com>, <linux-megaraid-devel@dell.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre7: build error with both megaraid drivers enabled
In-Reply-To: <20031011144400.GB25478@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0310110946070.7261-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the following build error when trying to compile both megaraid
> drivers statically into the kernel:

They both drive the same hardware, so this isn't such a good idea.  One or
the other, but not both please, at least not built-in.  Both as modules
should be fine, you'll only ever load one. It's not surprising that a few
functions are named the same between both.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

