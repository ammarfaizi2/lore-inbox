Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVILXZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVILXZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVILXZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:25:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932356AbVILXZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:25:57 -0400
Date: Mon, 12 Sep 2005 19:24:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Tom Watson <tsw@johana.com>, linux-kernel@vger.kernel.org
Subject: Re: Pruning the source tree (idea)
In-Reply-To: <9a8748490509111520186dcf0c@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0509121923130.28108@cuia.boston.redhat.com>
References: <4324A817.8050004@johana.com> <9a8748490509111520186dcf0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Jesper Juhl wrote:

> As for the "it speeds up grep" argument, that doesn't hold water, you 
> can just use the --include and --exclude arguments for grep to only 
> search relevant dirs.

"make tags" is your friend.

Then you can navigate the source code with any program that
understands ctags, including vim.

:ta <word>  to find a particular declaration or function
^]          to jump to the function or declaration of the
            word under your cursor
^t          to go back to where you came from

-- 
All Rights Reversed
