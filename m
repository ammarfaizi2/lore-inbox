Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUKEWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUKEWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUKEWI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:08:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:31540 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261187AbUKEWIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:08:23 -0500
Date: Sat, 6 Nov 2004 00:09:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [patch 1/2] Kbuild: avoid backup localversion files
Message-ID: <20041105230941.GA9604@mars.ravnborg.org>
Mail-Followup-To: blaisorblade_spam@yahoo.it, akpm@osdl.org,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20041102231958.94C7E4C07D@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102231958.94C7E4C07D@zion.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:19:57AM +0100, blaisorblade_spam@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> 
> (Please CC me on replies as I'm not subscribed).
> 
> Avoid including as localversion-files the *~ files, i.e. backup files. If I
> have localversion-a and localversion-a~, I don't want both to be used. Nor I
> want to use localversion*~ anyway.
> 
> Don't code that as $(wildcard localversion*[^~]) as that would exclude
> "localversion" from the wildcard expansion result, because it requires at
> least one character after localversion to exist in the name file. I.e., 

Applied,

	Sam
