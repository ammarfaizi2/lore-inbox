Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271147AbTGXHqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTGXHqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:46:52 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:35084 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271147AbTGXHqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:46:50 -0400
Date: Thu, 24 Jul 2003 09:01:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Flory <sflory@rackable.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac3 still broken on Adaptec I2O
Message-ID: <20030724090154.A25026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Samuel Flory <sflory@rackable.com>,
	"Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030723201801.GB32585@rdlg.net> <1058991837.5520.135.camel@dhcp22.swansea.linux.org.uk> <3F1EFC2F.8040109@rackable.com> <1058998652.6890.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058998652.6890.12.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 23, 2003 at 11:17:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 11:17:32PM +0100, Alan Cox wrote:
> Either way someone else can fix it if they want, or use the core
> i2o drivers which should drive this hardware nowdays

So why is dpt_i2o still around then?  It's a horrible mess and much
much worse than i2o_scsi.

