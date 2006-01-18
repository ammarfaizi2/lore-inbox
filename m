Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWARQX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWARQX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWARQX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:23:26 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:23711 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030375AbWARQX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:23:26 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <20060118045518.GB7292@kroah.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 08:23:15 -0800
Message-Id: <1137601395.7850.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 20:55 -0800, Greg KH wrote:
> On Tue, Jan 17, 2006 at 09:25:14AM -0800, Dave Hansen wrote:
> > 
> > Arjan had a very good point last time we posted these: we should
> > consider getting rid of as many places in the kernel where pids are used
> > to uniquely identify tasks, and just stick with task_struct pointers.  
> 
> That's a very good idea, why didn't you do that?

Because we were being stupid and shoudn't have posted this massive set
of patches to LKML again before addressing the comments we got last
time, or doing _anything_ new with them.

-- Dave

