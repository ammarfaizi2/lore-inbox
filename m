Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262014AbSITJWd>; Fri, 20 Sep 2002 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbSITJWc>; Fri, 20 Sep 2002 05:22:32 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:43439 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262014AbSITJWc>; Fri, 20 Sep 2002 05:22:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Stephen C. Tweedie" <sct@redhat.com>, Seaman Hu <seaman_hu@yahoo.com>
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
Date: Fri, 20 Sep 2002 11:27:28 +0200
User-Agent: KMail/1.4.3
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
References: <20020920073927.71003.qmail@web40504.mail.yahoo.com> <20020920091114.46162.qmail@web40502.mail.yahoo.com> <20020920102052.B2585@redhat.com>
In-Reply-To: <20020920102052.B2585@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209201127.28482.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, that's a known problem when you run out of inodes.  Ext3
> incorrectly treated it as a full fs error.  That's been fixed in -ac,
> ext3 CVS and the Red Hat kernels for a while, and it's in Marcelo's
> post-2.4.19 tree.

Do you know a good way to recover from this when it happens?
The problem being that when you reboot it immediately happens
again...  I managed to recover from this but it required some time
and tricks (see other email to list) - perhaps you know an easy way?

All the best,

Duncan.
