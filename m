Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEROOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEROOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVERONX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:13:23 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29658 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261194AbVEROM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:12:57 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: dino@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050518090722.GA3937@in.ibm.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave>  <20050518090722.GA3937@in.ibm.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 09:12:39 -0500
Message-Id: <1116425559.5027.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 14:37 +0530, Dinakar Guniguntala wrote:
> It works !! Thanks.
> 
> So are these patches getting into -mm first or -rc5 ??

Damn, I knew you were going to ask that ... the problem is it's the last
in a long line of invasive adaptec patches that sit in my scsi-misc-2.6
tree ... I suppose we can't have the aic driver slightly hosed for
2.6.12; I'll see if I can extract them.

James


