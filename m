Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWFKK25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWFKK25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFKK25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:28:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:37434 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932110AbWFKK25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:28:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCbdCRLS6UPXLCvVsXgbQtP9QlQeJkU78WLZRlCpJxdkfLWtSKE9b79Kv+63svNNl6gjD6EbUmuYNWLgo4d9ZL0o5MvMecC2mPmPgwdP5EE8lTG2eqgHWWzy1Trr+edwMgHCgocMZI0TgdDa6t/4vpzsCgILJA0OAr98IlIEg2Y=
Message-ID: <20f65d530606110328l5287cdf1ha4579f4120ed8ae9@mail.gmail.com>
Date: Sun, 11 Jun 2006 22:28:56 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200606110211_MC3-1-C21E-301E@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606110211_MC3-1-C21E-301E@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck

> Whether IO-APIC caused this bug or not, it's hard to say...
>

We tested it with pci=noacpi, and it has been stable for 36 hours now.
It looks like it has something to do with that.

Regards
Keith
