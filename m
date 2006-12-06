Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937720AbWLFWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937720AbWLFWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937721AbWLFWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:10:59 -0500
Received: from hu-out-0506.google.com ([72.14.214.231]:4349 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937720AbWLFWK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:10:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=msNPrg92XRezse0O+BUNWb8ni3CL3JilkhTZvF3r0eLDMud3LnV3CQG1yrv9rnpubZSUdQeemIsUEMR81hJWhrHfu6V/R5oS4fv2/asMGdZVY1o/J/qp4RGBh0ciowMNCMOtwjzpC6kZgcP510gZYFKEHHIyZWf+G5n8Cr/lRK0=
Message-ID: <d120d5000612061410l3f4e0c4x60c5456c17ef4d61@mail.gmail.com>
Date: Wed, 6 Dec 2006 17:10:56 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Benc" <jbenc@suse.cz>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: "Ivo van Doorn" <ivdoorn@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "John Linville" <linville@tuxdriver.com>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <20061206230546.41519771@logostar.upir.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <200612050027.15253.IvDoorn@gmail.com>
	 <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
	 <200612062031.57148.IvDoorn@gmail.com>
	 <d120d5000612061218x4eac87e0jc18409f82bb7c99c@mail.gmail.com>
	 <20061206230546.41519771@logostar.upir.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Jiri Benc <jbenc@suse.cz> wrote:
> On Wed, 6 Dec 2006 15:18:12 -0500, Dmitry Torokhov wrote:
> > On 12/6/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > > Ok, so input device opening should not block the rfkill signal and the rfkill handler
> > > should still go through with its work unless a different config option indicates that
> > > userspace wants to handle the event.
> >
> > I don't think a config option is a good idea unless by config option
> > you mean a sysfs attribute.
>
> What about using EVIOCGRAB ioctl for this?
>

Will not work when the button is on your USB keyboard ;)

-- 
Dmitry
