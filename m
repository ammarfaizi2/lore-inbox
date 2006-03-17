Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWCQQEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWCQQEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCQQEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:04:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33742 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751417AbWCQQEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:04:14 -0500
Subject: Re: [RFC][PATCH] warn when statically-allocated kobjects are used
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20060317013016.5C643E69@localhost.localdomain>
References: <20060317013016.5C643E69@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 17:04:03 +0100
Message-Id: <1142611444.3033.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +warn:
> +	printk("---- begin silly warning ----\n");
> +	printk("This is a janitorial warning, not a kernel bug.\n");

technically it IS a kernel bug ;)


