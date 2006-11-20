Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933918AbWKTFEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933918AbWKTFEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 00:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933919AbWKTFEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 00:04:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:7824 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933918AbWKTFEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 00:04:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ga+JIBD56mxELvbRFqxKysp+TpeHMmXk+e00Oq/1zmHH3Uz4CsbcJzQmG9YbadwQzFbUUerGt/EuYq6U0bWL7j8PSCi3iML1cfAunUpdbr4Mihl3+ORYaxYfNc94uPtepRMhTxzpYRxo61iUJq7kwZzwocOha9Zpy1ZSjxaiW8A=
Message-ID: <161717d50611192104u279ddbfdl58a65f275555f6e1@mail.gmail.com>
Date: Mon, 20 Nov 2006 00:04:51 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200611030103.17913.dtor@insightbb.com>
	 <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
X-Google-Sender-Auth: 35ca2168ed6ff2dd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
> On 11/3/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> >
> > Have you tried limiting Synaptics rate to 40 packets per second (using
> > psmouse.rate=40 option)? Some KBD can't handle full Synaptics rate of
> > 80 pps; it usually manifests in keyboard troubles.

This didn't seem to make a difference, but my reliable failure case
turned out to not be so reliable after all, so I'm at a loss again.
