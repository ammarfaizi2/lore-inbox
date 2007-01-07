Return-Path: <linux-kernel-owner+w=401wt.eu-S932607AbXAGQdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbXAGQdv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbXAGQdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:33:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:3382 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbXAGQdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:33:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ae+OURWyCX5J7nhO5A9n6NXr8ZBTiV4WyC0oRFScGcvpZNjcTmW/SbAP1FJO82U6a+YRe21AOnds3fpske4Aim++qs/aVXZXJoz8bkb4VSukvV2POG98nHLrWrcNG9AlliuPgMcoinhHgmQkI7AiU7ZH55vYiOhjVwugRuUUrsU=
Message-ID: <84144f020701070833i19cbb179md5426ca4b4be371c@mail.gmail.com>
Date: Sun, 7 Jan 2007 18:33:49 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.20-rc3-git4 oops on suspend: __drain_pages
Cc: "Christoph Lameter" <clameter@sgi.com>,
       "Robert Hancock" <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200701052036.10647.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <459DB116.9070805@shaw.ca>
	 <Pine.LNX.4.64.0701051114200.28395@schroedinger.engr.sgi.com>
	 <200701052036.10647.rjw@sisk.pl>
X-Google-Sender-Auth: 50f6d42a38b6e90a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Robert Hancock wrote:
> > > Saw this oops on 2.6.20-rc3-git4 when attempting to suspend. This only
> > > happened in 1 of 3 attempts.

On Friday, 5 January 2007 20:15, Christoph Lameter wrote:
> > See the fix that I posted yesterday to linux-mm. Its now in Andrew's tree.

On 1/5/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> I can't find it in -mm.
>
> Could you please post it here?

I think it's this:

http://marc.theaimsgroup.com/?l=linux-mm&m=116793590117896&w=2
