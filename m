Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWGUIz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWGUIz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWGUIz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:55:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37548 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030430AbWGUIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:55:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=b0MgCR/3jVg7dEV7nI1JL99ZTAbtIubcd3ntMrhlY/n52gHaHLjxxt6o7l+le/kMeXDpKTjjOMI9BObvWhaK07udB43DTC4I6E19nbbm6UnoW+IcISsV6DYTQYVOJ4JoEmMijppovh+retRSDIpOvSq2StNRFayZZXfuNg1ZNTM=
Message-ID: <84144f020607210155v628a51c7td93a647314f4ed78@mail.gmail.com>
Date: Fri, 21 Jul 2006 11:55:23 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Vadim Lobanov" <vlobanov@speakeasy.net>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Shorty Porty" <getshorty_@hotmail.com>,
       "Peter Williams" <pwil3058@bigpond.net.au>
In-Reply-To: <44C02F35.4000604@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153445087.44c02cdf40511@portal.student.luth.se>
	 <44C02F35.4000604@garzik.org>
X-Google-Sender-Auth: 242b85c07ec9b578
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, Jeff Garzik <jeff@garzik.org> wrote:
> I would say:
>
> #undef true
> #undef false
> enum {
>         false   = 0,
>         true    = 1
> };
>
> #define false false
> #define true true

Just curious, why the #defines?
