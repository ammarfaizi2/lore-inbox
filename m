Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWDUMLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWDUMLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDUMLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:11:54 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:18587 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932112AbWDUMLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:11:53 -0400
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tony Jones <tonyj@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060420175043.GA32382@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
	 <20060419221248.GB26694@infradead.org> <20060420053604.GA15332@suse.de>
	 <1145521570.3023.8.camel@laptopd505.fenrus.org>
	 <20060420164329.GA30219@suse.de> <20060420170419.GA20791@infradead.org>
	 <20060420175043.GA32382@suse.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 08:16:19 -0400
Message-Id: <1145621779.21749.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 10:50 -0700, Tony Jones wrote:
> On Thu, Apr 20, 2006 at 06:04:19PM +0100, Christoph Hellwig wrote:
> 
> > p.s.: I also see that your patch doesn't include on to export d_path so
> > couldn't actually use it anyway. Not that a patch to export it would ever
> > be ACKed for above reasons..
> 
> Don't understand. Are you saying there is no EXPORT_SYMBOL for d_path?
> 
> I didn't add one as I didn't remove the old one.  It's still there.

Yes, it does appear to be exported already, presumably for nfsd.  Still
leaves open the question of whether it should be exported, or more
importantly what is considered legitimate use of it.

-- 
Stephen Smalley
National Security Agency

