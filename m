Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWAZTiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWAZTiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWAZTiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:38:22 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:33707 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751378AbWAZTiV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:38:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P9lAs4ROWOjd2KjvBOsac/qzx5aUMhryaPd9MeoJ174a8CM7xjcUgi5mYjXXnJLhyDx72cisJ6VPd4wZhQW4pNzWJ45KNfQcE2ajo7I9xUKrjSW7GV9cgRQnsRo43NLp0iFSmRGXF7Y9763HNXK1tCSQ98MYu4NZNZDmak1Yi5o=
Message-ID: <5a2cf1f60601261138t57ab74ebl7ab201d73226fa7b@mail.gmail.com>
Date: Thu, 26 Jan 2006 20:38:20 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
In-Reply-To: <43D8D69F.nailE2XAJ2XIA@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
	 <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner>
	 <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
	 <43D8D69F.nailE2XAJ2XIA@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
>
> > As a Linux user, the only reason I do cdrecord -scanbus is to comply
> > to the cdrecord way of doing likes. I don't personally like it.
> >
> > I'd rather use /dev/cdrw, in a machine independent way, as in:
> >
> >   ssh user@host cdrecord dev=/dev/cdrw /path/to/file.iso
>
> On the vast majority of OS this does not work.

1- I don't care if that works or not on other OSes. This is a
fonctionality I expect to work on my target host.

2- cdrecord locks the user inside its own terminology, instead of a
being open to the platform, for 'cross-platform compatibility reasons'

Sorry but I don't buy any of that.

Now, if someone was to provide you with patches to support the Linux
way of doing things, keeping all your functionality as it is today,
just reorganizing the code in a slightly different way, would you
consider looking at the patches?

Jerome
