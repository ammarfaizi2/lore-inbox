Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTFDVUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTFDVUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:20:02 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:64520 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S264095AbTFDVT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:19:57 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm4
Date: Wed, 4 Jun 2003 23:33:26 +0200
User-Agent: KMail/1.5.2
References: <20030603231827.0e635332.akpm@digeo.com>
In-Reply-To: <20030603231827.0e635332.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306042333.26850.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 08:18, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70
>-mm4/
>

I got the following errors with every file that includes 
include/linux/bitops.h

include/linux/bitops.h: In function `generic_hweight64':
include/linux/bitops.h:118: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:118: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:119: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:119: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:120: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:120: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:121: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:121: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:122: warning: integer constant is too large for "long" 
type
include/linux/bitops.h:122: warning: integer constant is too large for "long" 
type

This is on UP, athlon, gcc 3.3

	Rudmer

