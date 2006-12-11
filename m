Return-Path: <linux-kernel-owner+w=401wt.eu-S936563AbWLKOx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936563AbWLKOx7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936678AbWLKOx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:53:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:55340 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936615AbWLKOxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:53:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKrlJycgybiddzKqw/5cgc9UvKo2AWKDlaenw0YSyZBBextl7fhZhe0BMcQSdyf+V4WFxn2EBQB1zMK6w9LmicmFZckGgDugWyu1zVoX3u1JlolQdlkI3wSC5vSS0DV/fMVD/ZuzOUSY7EaSCrnV9AE/p6OOwV4VUTTrapNKj1o=
Message-ID: <3f250c710612110653l7827c4dcg4bb47adbe7fe08e8@mail.gmail.com>
Date: Mon, 11 Dec 2006 10:53:50 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: kobject_uevent() question
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <457C3E11.8050401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061128161218.43358.qmail@web51813.mail.yahoo.com>
	 <90539.55300.qm@web51815.mail.yahoo.com>
	 <20061128195532.GA13705@kroah.com> <457C3E11.8050401@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

I have posted a patch for that as well. You can check it at
http://lkml.org/lkml/2006/11/30/315.

BR,

Mauricio Lin.

On 12/10/06, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
> Greg KH wrote:
> > On Tue, Nov 28, 2006 at 07:38:01PM +0000, Mauricio Lin wrote:
> >> Hi Greg,
> >>
> >> It is working now. The failure was in the kobject_uevent() function. As
> >> the kset of my kobject was not set properly, the kobject_uevent()
> >> function just returned void.
> >>
> >> I wonder why the kobjec_uevent() does not return an integer to indicate
> >> if the operation was completed with success or not.
> >
> > Feel free to send patches fixing this issue :)
> >
> > thanks,
> >
> >
>
> Something like this ?
>
> -aneesh
>
>
>
