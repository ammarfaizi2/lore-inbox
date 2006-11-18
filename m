Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756329AbWKROlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbWKROlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756334AbWKROlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:41:17 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:46465 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1756329AbWKROlQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:41:16 -0500
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Stephen.Clark@seclark.us
Subject: Re: IEEE80211 and IPW3945
Date: Sat, 18 Nov 2006 16:41:13 +0200
User-Agent: KMail/1.9.5
Cc: jketreno@linux.intel.com, linux-kernel@vger.kernel.org
References: <20061118102056.GA4492@gimli> <200611181449.53483.ismail@pardus.org.tr> <455F180A.9080301@seclark.us>
In-Reply-To: <455F180A.9080301@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611181641.14429.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

18 Kas 2006 Cts 16:26 tarihinde, Stephen Clark şunları yazmıştı: 
> Ismail Donmez wrote:
> >18 Kas 2006 Cts 12:20 tarihinde, Martin Lorenz ÅŸunlarÄ± yazmÄ±ÅŸtÄ±:
> >>Dear James,
> >>
> >>I just had some issues when trying to compile ieee80211 1.2.15 together
> >>with ipw3945 1.1.2 on the latest kernel tree
> >>
> >>attached are two patches I had to create to work around it
> >>I guess they are self-explanatory :-)
> >
> >I wonder when will ieee80211 tree will be merged to mainline, according to
> >some posts[1] its needed for some devices.
> >
> >[1] http://www.ubuntuforums.org/showthread.php?t=156930
> >
> >/ismail
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> On Mon, 13 Nov 2006 08:42:55 -0500 Stephen Clark wrote:
> >> can someone tell me why I have to replace the 803.11 stack that is
> >> already in
> >> linux 2.6.19 rc5 with the stack at sf.
>
> You don't have to.
> The one in .19-rc5 is new enough (the one in .18 too AFAIK)
>
> I have successfully run ipw3945 with FC6 using the ieee80211 stack from the
> kernel I just had to compile with:
>  make IEEE80211_API=2 EXTRA_CFLAGS=-DIEEE80211_API_VERSION=2

Nice tip! Thanks.

/ismail
