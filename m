Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWBMOMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWBMOMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWBMOMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:12:22 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:25321 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751783AbWBMOMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:12:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TajMBcxR8Oanf82aQSyQq6S6AsJDhXw+1Cwtfy9jJswbFWgcA6iXcZjYdcfz1nA6nrMr+FrNBm4lNH8qzuUIbjXedlFggB1NwaAlczz+YMBN360jTCPYLb83vW58DTnHovGpbO9udPrExo4hE0PRqETwwhO2fbZyiGfThBYmiK8=
Message-ID: <5a2cf1f60602130612w1452f21jf41a3aa10ceedc05@mail.gmail.com>
Date: Mon, 13 Feb 2006 15:12:21 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
In-Reply-To: <43EC8F22.nailISDL17DJF@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
>
> > And does cdrecord even need libscg anymore? From having actually gone through
> > your code, Joerg, I can tell you that it does serve a larger purpose. But at
> > this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_
> > writing programs, does _ANYONE_ use libscg? Is it ever used to access any
> > other devices that are either SCSI or use a SCSI command protocol (like
> > ATAPI)?  My point there is that you have a wonderful library, but despite
> > your wishes, there is no proof that it is ever used for anything except
> > writing/ripping CD's.
>
> Name a single program (not using libscg) that implements user space SCSI and runs
> on as many platforms as cdrecord/libscg does.

As an application developer, I would focus on the following questions:

* what is the percentage of Windows users using a CD burning/ripping
program based on libscg?

* what is the percentage of cdrecord Linux users out of the total
number of cdrecord users?

* what are your expectations with regard to those numbers in the future?

Jerome
