Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTDOLtX (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTDOLtX 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:49:23 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.29]:15241 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261223AbTDOLtW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 07:49:22 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 14:01:00 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay>
In-Reply-To: <80690000.1050351598@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151401.00704.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 22:19, Martin J. Bligh wrote:
> Seems all these bug checks are fairly expensive. I can get 1%
> back on system time for kernel compiles by changing BUG to
> "do {} while (0)" to make them all compile away. Profiles aren't
> very revealing though ... seems to be within experimental error ;-(

What happens if you just turn BUG_ON into "do {} while (0)"?

Ciao,

Duncan.
