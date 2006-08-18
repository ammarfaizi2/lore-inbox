Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWHRPLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWHRPLt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWHRPLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:11:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:27597 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030475AbWHRPLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:11:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AyhTRhjUFbZAWSju2sThAj0QG7O5D13vbSE0P0gyXSwyyDSgi9oDkDtjAaopPJjjAz/OzbiHgpLnMfRsE6+0s/UcMFA0tKfrhME4ysfSuADGgK8cOKqcaLey15mdw+uhfYgMatYJqFNNtpZ3TpXhOHKiy1mu8Y+f7uRraqaNh2s=
Message-ID: <41b516cb0608180811m13a3d0bs90d1b9869ebaed59@mail.gmail.com>
Date: Fri, 18 Aug 2006 08:11:47 -0700
From: "Chris Leech" <christopher.leech@intel.com>
Reply-To: chris.leech@gmail.com
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 1/7] [I/OAT] Push pending transactions to hardware more frequently
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060818071157.GA7516@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060816005337.8634.70033.stgit@gitlost.site>
	 <20060818071157.GA7516@ucw.cz>
X-Google-Sender-Auth: 17d7ea102f5b0948
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Pavel Machek <pavel@ucw.cz> wrote:
>
> Huh, two version bumps for... ONE ONE-LINER :-).
>
> Could we get rid of embedded version? It helps no one.

Version numbers for drivers that can be built as modules are very
helpful for anyone wanting to upgrade a driver on top of a
distribution supported kernel.  If you always just use the latest
kernel source, you're right it doesn't help you.  But that's not
everyone.

This one skips two versions because I'm trying to sync up a 1.8
version tested internally with the 1.7+ upstream changes that's in the
kernel now.

I'll accept that the official policy is to not version modules when
MODULE_VERSION is removed :-)

- Chris
