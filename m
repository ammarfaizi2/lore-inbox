Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272481AbTGaNjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272482AbTGaNjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:39:10 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:9767
	"EHLO gaston") by vger.kernel.org with ESMTP id S272481AbTGaNjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:39:09 -0400
Subject: Re: mremap sleeping in incorrect context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730153439.7df44a69.akpm@osdl.org>
References: <1059586337.2420.44.camel@gaston>
	 <20030730153439.7df44a69.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059658728.2417.112.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 09:38:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> oops.  What are your CONFIG_HIGHMEM and CONFIG_HIGHPTE settings there?

this is on ppc32, HIGHPTE doesn't exist, HIGHMEM is enabled (1Gb of
RAM)

Ben.
