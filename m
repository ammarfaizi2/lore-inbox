Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWAREzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWAREzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWAREzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:55:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:19435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030182AbWAREzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:55:42 -0500
Date: Tue, 17 Jan 2006 20:55:18 -0800
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Message-ID: <20060118045518.GB7292@kroah.com>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap> <1137511972.3005.33.camel@laptopd505.fenrus.org> <20060117155600.GF20632@sergelap.austin.ibm.com> <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137518714.5526.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:25:14AM -0800, Dave Hansen wrote:
> 
> Arjan had a very good point last time we posted these: we should
> consider getting rid of as many places in the kernel where pids are used
> to uniquely identify tasks, and just stick with task_struct pointers.  

That's a very good idea, why didn't you do that?

thanks,

greg k-h
