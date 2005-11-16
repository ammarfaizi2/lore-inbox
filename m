Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbVKPUqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbVKPUqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVKPUqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:46:55 -0500
Received: from smtp.terra.es ([213.4.129.129]:44223 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S1030464AbVKPUqy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:46:54 -0500
Date: Wed, 16 Nov 2005 21:46:05 +0100
From: "Wed, 16 Nov 2005 21:46:05 +0100" <grundig@teleline.es>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: bunk@stusta.de, ak@suse.de, arjan@infradead.org, oliver@neukum.org,
       jmerkey@utah-nac.org, joern@wohnheim.fh-wedel.de, alex14641@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051116214605.545d1e4e.grundig@teleline.es>
In-Reply-To: <20051116190334.GC982@kvack.org>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
	<200511161630.59588.oliver@neukum.org>
	<1132155482.2834.42.camel@laptopd505.fenrus.org>
	<200511161710.05526.ak@suse.de>
	<20051116184508.GP5735@stusta.de>
	<20051116190334.GC982@kvack.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 16 Nov 2005 14:03:34 -0500,
Benjamin LaHaise <bcrl@kvack.org> escribió:

> We could implement a stack guard page for the transition period, so that 

CONFIG_DEBUG_STACKOVERFLOW doesn't do that but it looks useful too.

Does CONFIG_DEBUG_STACKOVERFLOW harm performance a lot? (doesn't 
look like that for a newbie's eye)
