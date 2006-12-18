Return-Path: <linux-kernel-owner+w=401wt.eu-S1754253AbWLRQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbWLRQlx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbWLRQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:41:53 -0500
Received: from mail.samba.org ([66.70.73.150]:54509 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbWLRQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:41:52 -0500
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 11:41:52 EST
Subject: Re: [linux-cifs-client] Re: 2.6.19.1 bug? tar: file changed as we
	read it
From: simo <idra@samba.org>
Reply-To: idra@samba.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Avi Kivity <avi@argo.co.il>, Andrew Morton <akpm@osdl.org>,
       Steve French <sfrench@samba.org>,
       linux-cifs-client <linux-cifs-client@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200612181115_MC3-1-D578-937D@compuserve.com>
References: <200612181115_MC3-1-D578-937D@compuserve.com>
Content-Type: text/plain
Organization: Samba Team
Date: Mon, 18 Dec 2006 11:22:36 -0500
Message-Id: <1166458956.30152.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 11:13 -0500, Chuck Ebbert wrote:

> With cifs, a directory search shows different sizes but opening
> them by name gives identical contents:
> 
> $ ll ipt_dscp* ipt_DSCP*
> -r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
> -r-------- 1 me me 2753 Jan 29  2004 ipt_DSCP.c
> $ ll ipt_dscp.c ipt_DSCP.c
> -r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
> -r-------- 1 me me 1581 Jan 28  2004 ipt_DSCP.c
> $ diff ipt_dscp.c ipt_DSCP.c
> $
> 
> So where is the bug? On the server?

What is the server?
Samba? Which vertsion?
Do you use unix extensions? Or "case sensitive = yes" ?

Simo.

-- 
Simo Sorce
Samba Team GPL Compliance Officer
email: idra@samba.org
http://samba.org

