Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVHINSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVHINSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHINSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:18:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13707 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932531AbVHINSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:18:48 -0400
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Habets <thomas@habets.pp.se>
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org,
       vinays@burntmail.com
In-Reply-To: <200508091133.21837.thomas@habets.pp.se>
References: <42F8720D.4060300@picsearch.com>
	 <200508091133.21837.thomas@habets.pp.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 14:44:47 +0100
Message-Id: <1123595087.15600.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0 - overcommit except if something is obviously silly
1 - overcommit always (some scientific workloads)
2 - don't overcommit (databases etc)

