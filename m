Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVJXLcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVJXLcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 07:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVJXLcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 07:32:36 -0400
Received: from ns1.nict.go.jp ([133.243.3.1]:27365 "EHLO ns1.nict.go.jp")
	by vger.kernel.org with ESMTP id S1750897AbVJXLcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 07:32:35 -0400
Date: Mon, 24 Oct 2005 20:32:17 +0900
From: CHIKAMA masaki <masaki-c@nict.go.jp>
To: linux-kernel@vger.kernel.org
Subject: Re: The fasync_cache grows.  Possible leak in kernel 2.6.13.4.
Message-Id: <20051024203217.40b6f503.masaki-c@nict.go.jp>
In-Reply-To: <20051024105134.35825d59.masaki-c@nict.go.jp>
References: <20051024105134.35825d59.masaki-c@nict.go.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I disable fs.leases-enable (sysctl -w fs.leases-enable=0) and 
the problem is solved. 

Thanks.
-- 
CHIKAMA Masaki @ NICT

