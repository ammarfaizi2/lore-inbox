Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUIJB5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUIJB5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIJB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:57:41 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:19990 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S266574AbUIJB53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:57:29 -0400
Date: Fri, 10 Sep 2004 03:57:15 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: patches failing - is 2.6.9-rc1 patch against 2.6.8? (not 2.6.8.1)
Message-ID: <20040910015715.GC31473@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040909214208.3b259016@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040909214208.3b259016@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 09:42:08PM -0400, Johann Koenig wrote:
> I get the following when trying to get the 2.6.9-rc1 kernel:
> 
> jkoenig@note:/usr/src$ grep -i fail patch.rc1.info -A5 -B5
> patching file Makefile
> Hunk #1 FAILED at 1.
> 1 out of 13 hunks FAILED -- saving rejects to file Makefile.rej
> patching file fs/nfs/file.c
> Hunk #2 FAILED at 74.
> Hunk #3 FAILED at 91.
> 2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej

 You are probably patching 2.6.8.1. That's wrong way. 2.6.9-rc1.patch is
made against 2.6.8.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

