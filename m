Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVCCMBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVCCMBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCCLJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:09:50 -0500
Received: from mx1.mail.ru ([194.67.23.121]:53034 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261540AbVCCKv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:51:26 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jaka =?utf-8?q?Mo=C4=8Dnik?= <jaka@activetools.si>
Subject: Re: [PATCH] trivial fix for 2.6.11, initializing a few spin locks
Date: Thu, 3 Mar 2005 13:51:38 +0200
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <1109843825.29455.17.camel@x.at.lan>
In-Reply-To: <1109843825.29455.17.camel@x.at.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <200503031351.38860.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 11:57, Jaka Močnik wrote:
> this patch for 2.6.11 simply initializes a few spin locks that are being
> reported as accessed prior to initalization on an embedded ppc system.

Please, split'em. Put Signed-off-by right after changelog comment and
_before_ the patch.

> --- cut here ---

This may screw scripts. "--- " sequence is magic.

Oh, and don't put 2.6.11 in Subject and changelog.

	Alexey
