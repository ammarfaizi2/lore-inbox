Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWHWLvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWHWLvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWHWLva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:51:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:7148 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932429AbWHWLva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:51:30 -0400
To: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Group limit for NFS exported file systems
References: <20060823091652.235230@gmx.net>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 13:51:28 +0200
In-Reply-To: <20060823091652.235230@gmx.net>
Message-ID: <p73u043656n.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert Szentmihalyi" <robert.szentmihalyi@gmx.de> writes:

> is there a group limit for NFS exported file systems in recent kernels?
> One if my users cannot access directories that belong to a group he actually _is_ a member of. That, however, is true only when accessing them over NFS. On the local file system, everything is fine. UIDs and GIDs are the same on client and server, so that cannot be the problem. Client and server run Gentoo Linux with kernel 2.6.16 on the server and 2.6.17 on the client.

NFSv2 has a 8 groups limit in the protocol iirc.

-Andi
