Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWDTUWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDTUWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDTUWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:22:08 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:27572 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751254AbWDTUWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:22:06 -0400
Date: Thu, 20 Apr 2006 16:22:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Tony Jones <tonyj@suse.de>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
In-Reply-To: <20060420194503.GA1425@suse.de>
Message-ID: <Pine.LNX.4.64.0604201619160.16908@d.namei>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
 <20060420124647.GD18604@sergelap.austin.ibm.com>
 <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>
 <20060420132128.GG18604@sergelap.austin.ibm.com> <20060420194503.GA1425@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Tony Jones wrote:

> We have lmbench results.  We had issues getting reproducability out of dbench
> but need to look at it some more.

Which filesystem were you running dbench on?  IIRC, journaling plays 
havoc with it and you need to use something like ext2 to get reliable 
data.

(Even though dbench is generally frowned upon, it's useful in situations 
like this where you're not tuning fs code or similar).



- James
-- 
James Morris
<jmorris@namei.org>
