Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVA2G2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVA2G2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVA2G2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:28:41 -0500
Received: from one.firstfloor.org ([213.235.205.2]:10210 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262865AbVA2G2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:28:40 -0500
To: Christopher Li <chrisl@vmware.com>
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: Re: compat ioctl for submiting URB
References: <20050128212304.GA11024@64m.dyndns.org>
	<1106972991.3972.57.camel@sherbert>
	<20050129013305.GA7792@64m.dyndns.org>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 Jan 2005 07:28:39 +0100
In-Reply-To: <20050129013305.GA7792@64m.dyndns.org> (Christopher Li's
 message of "Fri, 28 Jan 2005 20:33:05 -0500")
Message-ID: <m1pszolpew.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li <chrisl@vmware.com> writes:

> This patch is for the case that running 32 bit application on
> a 64 bit kernel. So far only x86_64 allow you to do that.
>
> I am not aware of other 64bit architecture need the 32bit
> emulation.

A lot of them do. Just use CONFIG_COMPAT instead.

-Andi
