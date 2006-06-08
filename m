Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWFHXkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWFHXkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWFHXkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:40:47 -0400
Received: from main.gmane.org ([80.91.229.2]:22660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964858AbWFHXkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:40:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Idea about a disc backed ram filesystem
Date: Fri, 09 Jun 2006 00:40:31 +0100
Message-ID: <yw1x4pyvdxn4.fsf@agrajag.inprovide.com>
References: <200606082233.13720.Sash_lkl@linuxhowtos.org> <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:70j9CybcVmiSxUQHzw9qA317wpc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matheus Izvekov" <mizvekov@gmail.com> writes:

> My idea consisted of adding the capability to specify a device for
> tmpfs mounting. if you dont specify any device, tmpfs continues to
> behave the way it currently is. But if you do, once data doesnt fit on
> ram (or some other limit) anymore, it will flush things to this
> device. my intention was to reuse swap code for this, so you mount a
> tmpfs passing the dev node of some unused swap device, and it works
> just like tmpfs with a dedicated swap partition.

I don't see what advantage this would have over normal tmpfs.

-- 
Måns Rullgård
mru@inprovide.com

