Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754887AbWKWIZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbWKWIZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbWKWIZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:25:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:64231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754887AbWKWIZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:25:36 -0500
Date: Thu, 23 Nov 2006 00:22:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: security: introduce file caps
Message-Id: <20061123002207.5e18bade.akpm@osdl.org>
In-Reply-To: <20061123001458.fe73f64a.akpm@osdl.org>
References: <20061114030655.GB31893@sergelap>
	<20061123001458.fe73f64a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 00:14:58 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 13 Nov 2006 21:06:55 -0600
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > Implement file posix capabilities.  This allows programs to be given
> > a subset of root's powers regardless of who runs them, without
> > having to use setuid and giving the binary all of root's powers.
> 
> With this patch applied, my X server fails to exit when I do the normal
> logout thing from the KDE menus.

After a manual kill of the X server I see on the VT:

xinit: Operation not permitted (errno 1): Can't kill X server

