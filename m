Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUKGShL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUKGShL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUKGShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 13:37:11 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:30171 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261671AbUKGShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 13:37:08 -0500
Date: Sun, 7 Nov 2004 13:33:53 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/coda/psdev.c shouldn't include lp.h
Message-ID: <20041107183353.GE5224@delft.aura.cs.cmu.edu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041107005258.GY1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107005258.GY1295@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 01:52:58AM +0100, Adrian Bunk wrote:
> I don't see any reason why fs/coda/psdev.c includes lp.h

Agreed, my guess is that many of the includes were inherited from
some template and aren't actually necessary.

Jan

