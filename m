Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWJXMMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWJXMMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWJXMMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:12:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:30382 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161008AbWJXMMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qVK7arC3CTeD00Z4JQrmzF7jgrInhBA3FQ9QLE/Uk8toa/+JDk6sUIa5b4FeKwDUgtmEJTCIj8oui4SqbtKhx3eB/P8UMMd7Fp/SEkr/qICGPwq8c5PyfKXYRihb/Dq3PxGkTKRlNWAm84g9c4BIIw5HZbsYqrHcxKptHGX5FMA=
Message-ID: <84144f020610240512y80a41bblcf8ce08c3875c008@mail.gmail.com>
Date: Tue, 24 Oct 2006 15:12:39 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: incorrect taint of ndiswrapper
Cc: "Giridhar Pemmasani" <pgiri@yahoo.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20061023201135.0d8766c9.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161608452.19388.31.camel@localhost.localdomain>
	 <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
	 <20061023201135.0d8766c9.rdunlap@xenotime.net>
X-Google-Sender-Auth: 2c1252254efd3215
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> The kernel should not depend on a not-in-tree kernel module to
> taint the kernel.  The kernel can and should do that itself.

Agreed. But should the kernel disallow the use of _GPL symbols for
ndiswrapper? I would say no.
