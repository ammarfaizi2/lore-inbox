Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbSJAP3G>; Tue, 1 Oct 2002 11:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJAP3G>; Tue, 1 Oct 2002 11:29:06 -0400
Received: from brule.borg.umn.edu ([160.94.232.10]:36422 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S261697AbSJAP2g>; Tue, 1 Oct 2002 11:28:36 -0400
Date: Tue, 1 Oct 2002 10:33:48 -0500
From: Peter Bergner <peter@bergner.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, anton@samba.org, jdike@karaya.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sigcontext_struct -> sigcontext
Message-ID: <20021001103348.A1124078@brule.borg.umn.edu>
References: <20020925170742.410f3887.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20020925170742.410f3887.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
: PPC and PPC64 are the only two architectures that define a struct
: sigcontext_struct - all the others use struct sigcontext (UML seems to
: have been infected :-)). This patch just renames sigcontext_struct to
: sigcontext.  It also renames sigcontext32_struct to sigcontext.

I've merged this into the PPC64 2.4 tree.  Thanks.

Peter


