Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267307AbUHDSrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUHDSrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHDSrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:47:36 -0400
Received: from nacho.alt.net ([207.14.113.18]:12682 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S267307AbUHDSr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:47:26 -0400
Date: Wed, 4 Aug 2004 11:47:20 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <Pine.LNX.4.44.0408040805180.1636-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0408041146090.16585-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction: I have been using client_oplocks.txt, not client_plain.txt, in
this repro.  (both were in the directory, but it is oplocks.txt one that
is being defaulted to)

Chris

On Wed, 4 Aug 2004, Chris Caputo wrote:
> 2) run loop_dbench, which is the following dbench script which uses 
>    client_plain.txt:
> 
>    #!/bin/sh
> 
>    while [ 1 ]
>    do
>         date
>         dbench 2
>    done

