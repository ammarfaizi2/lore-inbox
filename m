Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDSFXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDSFXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 01:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDSFXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 01:23:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24030 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750819AbWDSFX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 01:23:29 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: casey@schaufler-ca.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Crispin Cowan <crispin@novell.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060418230931.40039.qmail@web36612.mail.mud.yahoo.com>
References: <20060418230931.40039.qmail@web36612.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 07:23:23 +0200
Message-Id: <1145424203.3058.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 16:09 -0700, Casey Schaufler wrote:
> --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > ... A file name is a pretty
> > meaningless object in Unixspace ...
> 
> Stephen is right that the inode is the object.
> Crispin is right that people care about path names.
> 
> The linux-audit folks have been hashing this
> about good and hard. It is true that both the
> pathname /etc/shadow and the inode it represents
> are interesting from various secuirty viewpoints.
> If you insist on either being the definitive
> security referent you will be wrong about half
> the time.

just that LSM is inode based ;)


