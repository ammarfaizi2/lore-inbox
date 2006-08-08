Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWHHMQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWHHMQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWHHMQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:16:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:60060 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932561AbWHHMQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:16:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KoDdms7FBLvoo8So9Z6I+gjU3l1fwfGqhqHU9cxIYDEgm7waT6Qf0ME9mTKwNIwrSJbYixvrlTTEtkNSVBIzhejIvLDYtkbT9AfBpfEDlBa2VOaHODYRbwPNtfs/I94EYyMVbINwKsynvobHWKEH7K7q3Nb4qxj6NWTwioRtVf4=
Message-ID: <84144f020608080516k183072efmdcc8a4dfc334b2fe@mail.gmail.com>
Date: Tue, 8 Aug 2006 15:16:10 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Chase Venters" <chase.venters@clientec.com>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Daniel Jacobowitz" <dan@debian.org>,
       "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608071813.18661.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <eb8g8b$837$1@taverner.cs.berkeley.edu>
	 <20060807225642.GA31752@nevyn.them.org>
	 <200608071813.18661.chase.venters@clientec.com>
X-Google-Sender-Auth: b6002b80592b6699
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 07 August 2006 17:56, Daniel Jacobowitz wrote:
> > No, that's already been answered at least once.  The file remains open,
> > but returns EBADF on various operations.

On 8/8/06, Chase Venters <chase.venters@clientec.com> wrote:
> IIRC, it returns EBADF because the file actually gets closed. The file
> descriptor, on the other hand, is permanently leaked.
>
> Have these details changed?

No. Your description is accurate.

                                             Pekka
