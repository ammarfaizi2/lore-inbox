Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTGXLQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGXLQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:16:19 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:28406 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262283AbTGXLQO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:16:14 -0400
Subject: Re: 2.6.0-test1-ac3 still broken on Adaptec I2O
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Samuel Flory <sflory@rackable.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030724090154.A25026@infradead.org>
References: <20030723201801.GB32585@rdlg.net>
	 <1058991837.5520.135.camel@dhcp22.swansea.linux.org.uk>
	 <3F1EFC2F.8040109@rackable.com>
	 <1058998652.6890.12.camel@dhcp22.swansea.linux.org.uk>
	 <20030724090154.A25026@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1059045840.7993.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 12:24:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 09:01, Christoph Hellwig wrote:
> On Wed, Jul 23, 2003 at 11:17:32PM +0100, Alan Cox wrote:
> > Either way someone else can fix it if they want, or use the core
> > i2o drivers which should drive this hardware nowdays
> 
> So why is dpt_i2o still around then?  It's a horrible mess and much
> much worse than i2o_scsi.

Primarily because the i²o drivers didnt use to handle the dpt devices. They 
speak a slightly odd dialect of i²o and that tripped us up. I need to check
2.6 has all the 2.4 core i²o stuff in place. With that done then I think 
doing some testing and losing dpt_i2o is doable.

Alan

