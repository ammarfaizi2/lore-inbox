Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTFRUbC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFRUbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:31:02 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:59867 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S265468AbTFRUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:31:01 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler starvation
Date: Wed, 18 Jun 2003 22:44:56 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306182244.56920.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you seen this email I just posted to lkml?
>
> [PATCH] 2.5.72 O(1) interactivity bugfix
>
> It may be affecting the scheduler in all sorts of ways.

I've applied the patch you posted in your web page for 2.4.21-ck1. It feels 
more reactive but has an annoying collateral effect, it seems to slow down to 
new processes forked from an interactive program.

I see it when selecting a PGP signed message in kmail, it takes up to two 
seconds to show the message body. The lag wasn't so noticeable before.

Regards,
 
-- 
  ricardo galli       GPG id C8114D34
