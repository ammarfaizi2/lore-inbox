Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUFOHDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUFOHDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 03:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUFOHDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 03:03:18 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:41856 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265339AbUFOHDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 03:03:16 -0400
Subject: Re: In-kernel Authentication Tokens (PAGs)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Blair Strang <bls@asterisk.co.nz>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <87smcxqqa2.fsf@asterisk.co.nz>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
	 <1087080664.4683.8.camel@lade.trondhjem.org>
	 <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
	 <1087084736.4683.17.camel@lade.trondhjem.org>
	 <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com>
	 <87smcxqqa2.fsf@asterisk.co.nz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1087282990.13680.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 03:03:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 15/06/2004 klokka 02:38, skreiv Blair Strang:

> Surely the only logical reason to tag a process with extra security
> information /in the kernel/ is because that information is going to be
> used /by the kernel/.  I can't think of a good reason to put a
> generalised keystore in the kernel.

Here are three good reasons.

 - You want the key lifetime to be the same as your process lifetime
 - You want the key to be readable ONLY by that one process.
 - The kernel wants to supports multiple security realms and mechanisms.
Not everybody is happy with just kerberosV credentials, and we already
have beta code for the SPKM mechanism in RPCSEC_GSS.


As for the AFS PAG idea: it's already been shot down. See the
linux-fsdevel thread I referred to earlier.

Cheers,
  Trond
