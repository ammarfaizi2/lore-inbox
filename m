Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269516AbUHZTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269516AbUHZTxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269526AbUHZTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:50:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269504AbUHZTrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:47:21 -0400
Date: Thu, 26 Aug 2004 15:44:53 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408261543320.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Linus Torvalds wrote:

> So "/tmp/bash" is _not_ two different things. It is _one_ entity, that
> contains both a standard data stream (the "file" part) _and_ pointers to
> other named streams (the "directory" part).

OK, that makes sense.  

> Hey, think of it as a wave-particle duality. Both "modes" exist at the
> same time, and cannot be separated from each other. Which one you see
> depends entirely on your "experiment", ie how you open the file.

Guess I'm scared again now.  We need to make sure that
backup programs don't fall victim to the uncertainty
principle ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

