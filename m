Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUJOCPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUJOCPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUJOCPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:15:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60362 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268129AbUJOCPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:15:49 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, "Jack O'Quin" <joq@io.com>,
       torbenh@gmx.de
In-Reply-To: <1097805332.22673.63.camel@localhost.localdomain>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1097805332.22673.63.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1097806117.2682.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 22:08:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 21:55, Rusty Russell wrote:
> On Fri, 2004-10-01 at 07:14, Jody McIntyre wrote:
> > +/* module parameters */
> > +static int any = 0;			/* if TRUE, any process is realtime */
> > +MODULE_PARM(any, "i");
> 
> Please node that MODULE_PARM is deprecated.  This looks like a job for
> "module_param(any, bool, 0400)" or even "0644".  Please consider, and
> for the others.

This change (along with many other improvements) was already made by
Chris Wright.  An updated patch will probably be posted soon.

Lee

