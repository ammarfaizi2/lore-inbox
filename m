Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266235AbUFPKpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUFPKpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 06:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUFPKpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 06:45:08 -0400
Received: from mta-fs-be-03.sunrise.ch ([194.158.229.17]:50922 "EHLO
	mail-fs.sunrise.ch") by vger.kernel.org with ESMTP id S266235AbUFPKpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 06:45:05 -0400
From: Antille Julien <julien.antille@eivd.ch>
To: linux-kernel@vger.kernel.org
Subject: kacpid takes 99% of CPU when laptop lid is closed
Date: Wed, 16 Jun 2004 12:44:54 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406161244.55502.julien.antille@eivd.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that the ACPI bug I described 
here :http://marc.theaimsgroup.com/?l=linux-kernel&m=108452002205471&w=2
is still present in the recent 2.6.7 kernel.

However, the process taking all the CPU is kacpid now (was keventd in previous 
kernels)

I hope that helps.

Please add me to CC.

Julien Antille
