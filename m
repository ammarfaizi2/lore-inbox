Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757449AbWKWSks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbWKWSks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 13:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757450AbWKWSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 13:40:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757449AbWKWSkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 13:40:46 -0500
Date: Thu, 23 Nov 2006 10:39:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: security: introduce file caps
Message-Id: <20061123103920.8d908952.akpm@osdl.org>
In-Reply-To: <20061123131203.f7b6972f.chris@friedhoff.org>
References: <20061114030655.GB31893@sergelap>
	<20061123001458.fe73f64a.akpm@osdl.org>
	<20061123002207.5e18bade.akpm@osdl.org>
	<20061123131203.f7b6972f.chris@friedhoff.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 13:12:03 +0100
Chris Friedhoff <chris@friedhoff.org> wrote:

> xinit respects capabilities (at least i guess), so when the system has
> capability-support, the binary /usr/X11R6/bin/xinit neeeds the
> capability cap_kill even when no capability extended attribute exists
> for this binary.
> 
> setfcaps cap_kill=ep /usr/X11R6/bin/xinit
> 
> I documented this here:
> http://www.friedhoff.org/fscaps.html#Xorg,%20xinit,%20xfce,%20kde
> 
> and for more:
> http://www.friedhoff.org/fscaps.html
> 

Even when CONFIG_SECURITY_FS_CAPABILITIES=n?
