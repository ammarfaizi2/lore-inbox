Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWAFKu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWAFKu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWAFKu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:50:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:143 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S932400AbWAFKu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:50:58 -0500
Date: Fri, 6 Jan 2006 10:50:55 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 4/7] Mark some key VFS functions as __always_inline
Message-ID: <20060106105055.GU27946@ftp.linux.org.uk>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544072.2940.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136544072.2940.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:41:12AM +0100, Arjan van de Ven wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> 
> Mark a few VFS functions as mandatory inline (based on Al Viro's
> request); these must be inline due to stack usage issues during a recursive loop
> that happens during the recursive symlink resolution (symlink to a symlink to 
> a symlink ..)
> This patch at this point does not change behavior and is for documentation purposes
> only (but this changes later in the series)
> 
> 
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
ACK
