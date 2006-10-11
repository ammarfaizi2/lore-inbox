Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWJKPq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWJKPq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWJKPq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:46:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37239 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161082AbWJKPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:46:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hAKzbdMAEvxW3lXhVOK0ul0A15apAcYE0A1BoSBTi3zkcg9o5sdgzVjmIpfdLmLe27v0rCq62TbCVGkqz5wsYtHhYTdJe1Oyxh6BlIJfDakzI0u+/MUIWvQz0pme8IDWlojN3KwI9JLDAE0UpJfN9YJhWeIbbDTMHl9tfxyIJZ0=
Message-ID: <9a0545880610110846g2d06242ex1b53ca687fc47491@mail.gmail.com>
Date: Wed, 11 Oct 2006 08:46:44 -0700
From: "Steve Hindle" <mech422@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH] MD: conditionalize some code
Cc: "Jeff Garzik" <jeff@garzik.org>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <17708.12903.712376.255113@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010231631.GA18222@havoc.gtf.org>
	 <17708.12903.712376.255113@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Neil Brown <neilb@suse.de> wrote:
> On Tuesday October 10, jeff@garzik.org wrote:
> >
> > The autorun code is only used if this module is built into the static
> > kernel image.  Adjust #ifdefs accordingly.
> >

Greatt - thanks!  I wondered why my debian boxes weren't starting the
arrays unless I used mdadm
to 'poke' them.  I think I filed a bug with Debian regarding this -
I'll see if I can find/update it.

Steve
