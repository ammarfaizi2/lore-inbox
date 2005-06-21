Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFULeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFULeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFULbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:31:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261285AbVFULam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:30:42 -0400
Date: Tue, 21 Jun 2005 07:30:40 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
Message-ID: <20050621113040.GB592@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com> <20050621003203.GB28908@redhat.com> <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com> <20050621111301.GA592@redhat.com> <Pine.LNX.4.61.0506210714400.9115@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506210714400.9115@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 07:17:55AM -0400, Richard B. Johnson wrote:

 > >> Bullshit. The source is available to anybody who wants it.
 > >Great. Then please explain why you pull off this kind of crap..
 > >(DataLink/license.c)
 > Because it's true.

kernel/module.c:1259 disagrees with you.

static inline int license_is_gpl_compatible(const char *license)
{
    return (strcmp(license, "GPL") == 0
        || strcmp(license, "GPL v2") == 0
        || strcmp(license, "GPL and additional rights") == 0
        || strcmp(license, "Dual BSD/GPL") == 0
        || strcmp(license, "Dual MPL/GPL") == 0);
}

 > >MODULE_LICENSE("GPL\0 They won't allow GPL/BSD anymore!");

AFAICS, this is just plain deception. I suggest reading
http://marc.theaimsgroup.com/?l=linux-kernel&m=108304056922350&w=2
especially the part about talking to lawyers.

		Dave

