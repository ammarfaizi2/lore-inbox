Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269905AbUJMXHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269905AbUJMXHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbUJMXHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:07:06 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:2266 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269905AbUJMXHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:07:03 -0400
Message-ID: <35fb2e59041013160766469b06@mail.gmail.com>
Date: Thu, 14 Oct 2004 00:07:03 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Buddy Lucas <buddy.lucas@gmail.com>
Subject: Re: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
Cc: Stef van der Made <svdmade@planet.nl>,
       Radoslaw Szkodzinski <astralstorm@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5d6b657504101315086d6ef159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
	 <416D8999.7080102@pobox.com>
	 <Pine.LNX.4.58.0410131302190.31327@danga.com>
	 <416D8C33.9080401@osdl.org> <416D923B.3030404@planet.nl>
	 <f44c5fdf041013134726043453@mail.gmail.com>
	 <416D9B32.5030408@planet.nl>
	 <5d6b657504101315086d6ef159@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 00:08:24 +0200, Buddy Lucas <buddy.lucas@gmail.com> wrote:

> Compiling with -fomit-frame-pointer removes information from the
> binary that could be used for debugging. So the bugbuddy information
> you provided was not optimal, because it lacked the crucial stuff. ;-)
> The flag does not cause any problems, it is routinely used for
> compiling stuff  that doesn't need debugging.

It's worth adding that the reason why programs are often built with
-fomit-frame-pointer is for overhead reduction on stack frames, to
make the binary slightly smaller and run maybe a bit faster so it's
become quite popular. This discussion is beyond the scope of the
original mail, but worthy of noting - and it ends up going down the
path of differences between architectures, so let's just leave it at
this clarification.

Jon.
