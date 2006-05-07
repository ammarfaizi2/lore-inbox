Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWEGUrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWEGUrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 16:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWEGUrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 16:47:49 -0400
Received: from mout1.freenet.de ([194.97.50.132]:59019 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932225AbWEGUrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 16:47:48 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
Date: Sun, 7 May 2006 22:47:46 +0200
User-Agent: KMail/1.8.3
References: <200605071156.57844.jfritschi@freenet.de>
In-Reply-To: <200605071156.57844.jfritschi@freenet.de>
Cc: linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072247.46655.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After going over my patch again, i realized i missed the .cra_priority 
and .cra_driver_name setting in the crypto api struct. Here is an updated 
version of my patch:

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.17-2.diff 

And also a little patch for the generic twofish implementation adding the 
appropriate values :

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-priority-fix-2.6.17.diff

Regards,
Joachim

