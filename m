Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUHZSPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUHZSPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUHZSOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:14:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:1540 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269324AbUHZSLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:11:38 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: "Rodrigo FGV" <rodrigof@bifgv.com.br>
Subject: Re: Reiser 4
Date: Thu, 26 Aug 2004 20:11:28 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <006601c48bad$00c4b130$0700a8c0@ti10>
In-Reply-To: <006601c48bad$00c4b130$0700a8c0@ti10>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408262011.29436.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 22:40, Rodrigo FGV wrote:
> how i convert reiser3.6 to reiser4. this update is safe???

Backup / Format / Restore is the only way of migrating to Reiser4 (no magical 
tool to convert from reiser3-to-reiser4 is available ATM).

> the reiser4 have any critical bug?? anyone recommend this update???

It depends... I wouldn't recommend Reiser4 for production systems. AFAIK, 
there are still some pending minor bugs, but it's very unlikely that it will 
eat your data.
