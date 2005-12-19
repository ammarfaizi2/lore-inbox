Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVLSPAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLSPAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVLSPAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:00:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932149AbVLSPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:00:12 -0500
Date: Mon, 19 Dec 2005 15:00:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051219150007.GA9809@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@ftp.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051219013837.GF28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219013837.GF28038@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:38:37AM +0100, Ingo Molnar wrote:
> 
> introduce the mutex_debug type, and switch the semaphore APIs to it in a 
> type-sensitive way. Plain semaphores will still use the proper 
> arch-semaphore calls.

I think we shouldn't introduce this one.  It just encourages people to do
really things.  Everything else in the patchseries looks sensible to me.

