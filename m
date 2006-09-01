Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWIAOy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWIAOy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:54:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5848 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750739AbWIAOyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:54:55 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <20060901110948.GD15684@skybase>
References: <20060901110948.GD15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 07:54:39 -0700
Message-Id: <1157122479.28577.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are all of the un/likely()s in here really needed?

-- Dave

