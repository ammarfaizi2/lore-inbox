Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUBWS7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUBWS7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:59:47 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:45195 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261999AbUBWS7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:59:46 -0500
Date: Mon, 23 Feb 2004 21:00:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm3 (compile stats)
Message-ID: <20040223200045.GA2197@mars.ravnborg.org>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <1077562725.9079.7.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077562725.9079.7.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 10:58:45AM -0800, John Cherry wrote:
> 
> In file included from scripts/sumversion.c:6:
> scripts/modpost.h:12:23: elfconfig.h: No such file or directory
Missing dependency broke build with parallel builds. Rusty has it fixed
in latest version.

	Sam
