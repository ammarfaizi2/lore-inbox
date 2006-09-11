Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWIKTKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWIKTKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWIKTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:10:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964932AbWIKTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:10:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZxZ467fOg9+JyBkQInyxclXlzyU6a+apsVZ6mQwvMbmgLvJM+gF7ST4Ytavw99aEst4u/OMqmN7LUQ60kMB5ssjCVeEZukXZVPS2npNpXjL6qoD0Acw0Vzf4wtPGstTC6JKl8pizCOp2rUN96NGmaecGYD6ffNEmKpGkRTS8fJE=
Message-ID: <d120d5000609111210ud9ea310y40675db6e5edbed@mail.gmail.com>
Date: Mon, 11 Sep 2006 15:10:06 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
Subject: Re: [RFC] OLPC tablet input driver, take three.
In-Reply-To: <20060911190225.GS4181@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <20060910201036.GD4187@aehallh.com>
	 <20060911190225.GS4181@aehallh.com>
X-Google-Sender-Auth: 7752ef883755e47b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
>
> 4: Technical: I've not implemented the KCONFIG option for this driver
> yet, it's on my todo list, but for after we get the sample rate stuff
> figured out.
>
>
> That said, here the patch, it seems to work, and it's time to at least
> get into the OLPC kernel tree, if not mainline.
>

Zephaniah,

What are the chances that commodity hardware will have OLPC device
present? If there are none (or extremely slim) I think we'd better
wait for Kconfig option to be implemented before adding this to
mainline because psmouse is already too fat.

Otherwise it looks good.

-- 
Dmitry
