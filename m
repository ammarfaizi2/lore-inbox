Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbULFNsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbULFNsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULFNsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:48:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2450 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261249AbULFNss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:48:48 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Date: Mon, 6 Dec 2004 07:48:51 -0600
User-Agent: KMail/1.7.1
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
References: <20041206120941.GB7250@stusta.de>
In-Reply-To: <20041206120941.GB7250@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412060748.51047.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Monday 06 December 2004 6:09 am, Adrian Bunk wrote:
> drivers/md/dm-io.c copies functionality from bio.c .
>
> Is there a specific reason why you don't simply use the functionality
> bio.c provides?

Can you give some specific examples of the functionality you think is 
duplicated? Meanwhile, I'll take a look and see if I can explain any code 
overlaps.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
