Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSAIWmv>; Wed, 9 Jan 2002 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSAIWmc>; Wed, 9 Jan 2002 17:42:32 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:14093 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289056AbSAIWmL>; Wed, 9 Jan 2002 17:42:11 -0500
Date: Wed, 9 Jan 2002 22:41:59 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Eric Raymond <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <20020109154742.B28755@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201092238100.29914-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Eric S. Raymond wrote:

> The underlying problem is that dmidecode needs access to kmem, and I
> can't assume that the person running my configurator will be root.

But you can "su -c" (also sudo, I suppose).  If that person
doesn't have root, then building a kernel isn't going to do
them much good.

Matthew.

