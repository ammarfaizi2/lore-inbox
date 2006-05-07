Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWEGUtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWEGUtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEGUtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 16:49:13 -0400
Received: from mout2.freenet.de ([194.97.50.155]:55004 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932226AbWEGUtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 16:49:12 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
Date: Sun, 7 May 2006 22:49:11 +0200
User-Agent: KMail/1.8.3
References: <200605071157.03362.jfritschi@freenet.de>
In-Reply-To: <200605071157.03362.jfritschi@freenet.de>
Cc: linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072249.11577.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After going over my patch again, i realized i missed the .cra_priority 
and .cra_driver_name setting in the crypto api struct. Here is an updated 
version of my patch:

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-x86_64-asm-2.6.17-2.diff

And also a little patch for the generic twofish implementation adding the 
appropriate values :

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-priority-fix-2.6.17.diff

Regards,
Joachim
