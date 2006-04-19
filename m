Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDSFXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDSFXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 01:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWDSFXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 01:23:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750757AbWDSFW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 01:22:59 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: casey@schaufler-ca.com
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060418231657.68869.qmail@web36613.mail.mud.yahoo.com>
References: <20060418231657.68869.qmail@web36613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 07:22:55 +0200
Message-Id: <1145424176.3058.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 16:16 -0700, Casey Schaufler wrote:
> 
> --- James Morris <jmorris@namei.org> wrote:
> 
> 
> > No.  The inode design is simply correct.
> 
> If this were true audit records would not be required
> to contain path names. Names are important. To meet
> EAL requirements path names are demonstrably
> insufficient, but so too are inode numbers. Unless
> you want to argue that Linux is unevaluateable
> (a pretty tough position to defend) because it
> requires both in an audit record you cannot claim
> either is definitive.

audit != SELinux, simple as that
And yes audit on filenames is not too useful, but it is in some cases:
Consider the case where you want to log that someone tried to unlink
a file that doesn't exist. Inodes aren't going to do you any good ;)


