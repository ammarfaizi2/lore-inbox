Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLXAYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTLXAYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 19:24:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:54975 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262838AbTLXAYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 19:24:35 -0500
Date: Tue, 23 Dec 2003 16:24:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dale Amon <amon@vnl.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question on LFS in Redhat
Message-ID: <20031224002430.GY6438@matchmail.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <20031223151042.GE9089@vnl.com> <1072193917.5262.1.camel@laptop.fenrus.com> <20031223235827.GK9089@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223235827.GK9089@vnl.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 11:58:27PM +0000, Dale Amon wrote:
> But you wouldn't be able to handle file systems larger
> than 2TB then I presume?

Correct, I'd suggest 2.6 instead of patching your 2.4 kernel.  The 2.6
drivers have had more testing with large filesystems/block devices, and
that's very light, and even lighter on patched 2.4.
