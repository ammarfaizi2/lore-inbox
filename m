Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313290AbSDDSCB>; Thu, 4 Apr 2002 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313289AbSDDSBv>; Thu, 4 Apr 2002 13:01:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64626 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313288AbSDDSBr>; Thu, 4 Apr 2002 13:01:47 -0500
Date: Thu, 4 Apr 2002 12:59:54 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404125954.C27384@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com> <Pine.LNX.4.33.0204041625250.1089-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Apr 04, 2002 at 04:35:33PM +0100, Tigran Aivazian wrote:
> disappeared). Then, to make your thoughts consistent you would need to
> disable the exported interfaces required for development of a journalling

You assume EXPORT_SYMBOL is an exported, stable interface
that constitutes a GPL barrier. I disagree with
that and I think quite a few others do too.

That seems to be the core issue here...
