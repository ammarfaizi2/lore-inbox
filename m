Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWARWzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWARWzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWARWzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:55:41 -0500
Received: from [81.2.110.250] ([81.2.110.250]:12939 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932576AbWARWzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:55:40 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137613088.24321.60.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
	 <1137521557.5526.18.camel@localhost.localdomain>
	 <1137522550.14135.76.camel@localhost.localdomain>
	 <1137610912.24321.50.camel@localhost.localdomain>
	 <1137612537.3005.116.camel@laptopd505.fenrus.org>
	 <1137613088.24321.60.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 22:54:27 +0000
Message-Id: <1137624867.1760.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
> But, it seems that many drivers like to print out pids as a unique
> identifier for the task.  Should we just let them print those
> potentially non-unique identifiers, deprecate and kill them, or provide
> a replacement with something else which is truly unique?

Pick a format for container number + pid and document/stick with it -
something like container::pid (eg 0::114) or 114[0] whatever so long as
it is consistent


