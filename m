Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUJLIu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUJLIu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269538AbUJLIu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:50:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61660 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269531AbUJLIui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:50:38 -0400
Date: Tue, 12 Oct 2004 10:50:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: blaisorblade_spam@yahoo.it
cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 08/10] uml: mark broken configs
In-Reply-To: <20041012001801.7FD428697@zion.localdomain>
Message-ID: <Pine.LNX.4.61.0410121048480.7182@scrub.home>
References: <20041012001801.7FD428697@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Oct 2004 blaisorblade_spam@yahoo.it wrote:

> -menu "SCSI support"
> +if BROKEN
> +	menu "SCSI support"

You can add "depends on BROKEN" after the menu statement with the same 
effect.

bye, Roman
