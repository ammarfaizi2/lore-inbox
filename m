Return-Path: <linux-kernel-owner+w=401wt.eu-S936352AbWLIObU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936352AbWLIObU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936355AbWLIObU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:31:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:28637 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936352AbWLIObT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:31:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OxVoEWzTgc7ULFzDOfG154u6MVngCa/8rpWIAlRTrEuDvsMarqmh1UuPfZ0vq25yKS9mkGOFWGWKDtvgcH85XX7P7aZrN2HUshwIKpqiDWe4Z9NMMnXJsYIKSF129JupDBd4FqKb5WEx7JbSiXcQew5F8AATSTOfVPGHNp2JMzE=
Message-ID: <84144f020612090631ob345faah336460b64955ee14@mail.gmail.com>
Date: Sat, 9 Dec 2006 16:31:18 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612090913210.14456@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
	 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
	 <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain>
	 <84144f020612090613s28aeb485ua7c652393cff3f90@mail.gmail.com>
	 <Pine.LNX.4.64.0612090913210.14456@localhost.localdomain>
X-Google-Sender-Auth: f764d904b2f002f7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> no.  those two submissions represent two logically different "fixes"
> and i have no intention of combining them.

Like I said, fixing the order of kcalloc parameters with a follow-up
patch to use kzalloc is just plain stupid. You can ignore my review
comments all you want, but don't expect that bit to be merged. So, for
the record: NAK for that bit of the patch, it should be converted to
kzalloc instead. Thanks.

                              Pekka
