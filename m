Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSKFVQC>; Wed, 6 Nov 2002 16:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266104AbSKFVQC>; Wed, 6 Nov 2002 16:16:02 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:36112
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266101AbSKFVQB>; Wed, 6 Nov 2002 16:16:01 -0500
Subject: Re: Linux v2.5.46
From: Robert Love <rml@tech9.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 16:22:47 -0500
Message-Id: <1036617767.777.1394.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 18:13, Linus Torvalds wrote:

> Robert Love <rml@tech9.net>:
>   ...
>   o decoded wchan in /proc
>   ...

Just an fyi, the procps changes to support this new feature are now in
CVS.

CVS information, as well as CVS snapshots with the support, are
available from: http://tech9.net/rml/procps/

Note old procps packages will still work as the old wchan field is still
exported in stat.

Large machines using ps or top with the WCHAN field should see a
difference.  Also, procps no longer requires System.map.

	Robert Love

