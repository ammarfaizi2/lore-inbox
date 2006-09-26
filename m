Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWIZNYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWIZNYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWIZNYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:24:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:40564 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751175AbWIZNYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:24:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NK+LCY96Yefcq6sH1wSulA7isOzewhryFCVo043OWIKyH6ubtF80YU96gmGIPXKH9DmNFCtU+yEbTqWkAvHKhcSGifYqcSQFBCExtBMsXtkVZFf0fOy0V6AgZSRyKgFtoTrH7LziAL0MaDHyPmIhCnsOwT2AslDRIN30KF85tOk=
Message-ID: <d120d5000609260624j4fb1f45en6ce2339843fcc1ad@mail.gmail.com>
Date: Tue, 26 Sep 2006 09:24:15 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 30/47] Driver core: create devices/virtual/ tree
Cc: linux-kernel@vger.kernel.org, "Kay Sievers" <kay.sievers@vrfy.org>
In-Reply-To: <11592491803904-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060926053728.GA8970@kroah.com>
	 <11592491551919-git-send-email-greg@kroah.com>
	 <11592491581007-git-send-email-greg@kroah.com>
	 <11592491611339-git-send-email-greg@kroah.com>
	 <11592491643725-git-send-email-greg@kroah.com>
	 <11592491672052-git-send-email-greg@kroah.com>
	 <11592491704137-git-send-email-greg@kroah.com>
	 <11592491744040-git-send-email-greg@kroah.com>
	 <1159249177618-git-send-email-greg@kroah.com>
	 <11592491803904-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
>
> This change creates a devices/virtual/CLASS_NAME tree for struct devices
> that belong to a class, yet do not have a "real" struct device for a
> parent.  It automatically creates the directories on the fly as needed.
>

Why do you need multiple virtual devices? All parentless class devices
could grow from a single virtual device.

-- 
Dmitry
