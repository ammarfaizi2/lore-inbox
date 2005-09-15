Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbVIOTwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbVIOTwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbVIOTwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:52:39 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:33882 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965278AbVIOTwi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:52:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKEsAk38pdSSKXao3OAqBuEvuOpV3/weAtt+JIy3NzJkQhqC8dBl5rCoo3176Dn7ytbU/jKP3rx4efeQRVaKD1AdEh5CaS5RNiD9E/jUkVoPKE/bjdThLFzGUbpXqavytCVEEiG/yg6cbQ9mtlnAuAlpBmUCk8cbppk2rHVU6C0=
Message-ID: <d120d50005091512525d700862@mail.gmail.com>
Date: Thu, 15 Sep 2005 14:52:30 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Cc: Vojtech Pavlik <vojtech@suse.cz>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050915193143.GA7199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
	 <1126770894.28510.10.camel@station6.example.com>
	 <d120d50005091507225659868e@mail.gmail.com>
	 <1126795310.3505.47.camel@station6.example.com>
	 <20050915190700.GA3354@midnight.suse.cz>
	 <d120d50005091512226a339890@mail.gmail.com>
	 <20050915193143.GA7199@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Greg KH <gregkh@suse.de> wrote:
> On Thu, Sep 15, 2005 at 02:22:34PM -0500, Dmitry Torokhov wrote:
> >
> > Anyway, I think if Greg gives up and agrees on nesting classes all of
> > it can go in -mm for now and I will contact other maintainers to
> > verify that changes work. IIRC video/dvb mainatiners prefered all
> > changes to go through them.
> 
> No, I don't agree with this.  Give me a day to write up what I think we
> should do instead (something along the lines of "subclasses")
> 

Hmm.. nested class _is_ a subclass. It is just not a separate object
structure (like you don't have sub-devices either). But I guess I
better wait fro your write-up...

-- 
Dmitry
