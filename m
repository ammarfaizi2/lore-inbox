Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSATWT4>; Sun, 20 Jan 2002 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSATWTr>; Sun, 20 Jan 2002 17:19:47 -0500
Received: from ns.suse.de ([213.95.15.193]:9491 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288579AbSATWTc>;
	Sun, 20 Jan 2002 17:19:32 -0500
Date: Sun, 20 Jan 2002 23:19:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Frank Davis <fdavis@si.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3-pre2: isdn_common.c compile error
In-Reply-To: <Pine.LNX.4.33.0201201644001.1213-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201202318190.26934-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Frank Davis wrote:

> Hello all,
>     While 'make modules', I received the following error:
> isdn_common.c:2256: `ISDN_MINOR_B' undeclared (first use in this function)

ISDN_MINOR_B was 0 in old trees, so replacing the error line
with s/ISDN_MINOR_B + k/k/ would have same consequences.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

