Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWDXPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWDXPDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWDXPDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:03:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:57593 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWDXPDR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:03:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sf7raxC1cDDophD2zx3mAdGPucWDDSMcqYK2kHzMr/5soJ+2lk7EHQkKzx9BHTEF/gAvbxU4suYW8oL99YzUUrj3UtJ5rC3+1/wHQJQsu2CkQGe35v/pqamz7YM5MRUOHtW+zDY/Soyb9lxfNw3NtuSblpI688KaCv1cuajyU4Q=
Message-ID: <d120d5000604240803q387343dt8e9801a8cf21a975@mail.gmail.com>
Date: Mon, 24 Apr 2006 11:03:15 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20060424145747.GA5906@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060422204844.GA16968@skyscraper.unix9.prv>
	 <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com>
	 <20060424145747.GA5906@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Apr 24, 2006 at 10:31:39AM -0400, Dmitry Torokhov wrote:
> >
> > Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
> > people want to have ability to separate keyboards (via grabbing); they
> > also might want to control repeat rate independently. Shoudl we
> > reinstate these ioctls?
>
> I believe they were replaced by the ability to send EV_REP style events
> to the device, setting the repeat rate.
>

Argh, why am I always forgetting about ability to write events into devices?

--
Dmitry
