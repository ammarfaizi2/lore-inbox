Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTKYDQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKYDQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:16:44 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:45972 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262001AbTKYDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:16:42 -0500
Date: Tue, 25 Nov 2003 04:16:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031125031640.GB21351@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <20031124173527.GA1561@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124173527.GA1561@mail.shareable.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Jamie Lokier wrote:

> You seem to be suggesting that the only method is to have a separate
> partition for each user, which is absurd.

In a previous life, I've seen this happen on a Solaris box, where each
user's home directory was auto-mounted. I haven't tried to betray quotas
at that time though.

> /tmp is owned by root and anyone can create a hard link in /tmp to
> other files, on a system where /tmp doesn't have its own filesystem.

Convert /tmp to swap, mount -t tmpfs :-)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
