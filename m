Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936470AbWLFQpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936470AbWLFQpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936424AbWLFQpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:45:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51196 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936470AbWLFQpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:45:53 -0500
Message-ID: <4576F368.4070804@zytor.com>
Date: Wed, 06 Dec 2006 08:44:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <4576DED7.10800@zytor.com> <20061206152542.GS3927@implementation.labri.fr> <4576E134.5020109@zytor.com> <20061206153404.GU3927@implementation.labri.fr> <4576E355.7080708@zytor.com> <20061206161405.GV3927@implementation.labri.fr>
In-Reply-To: <20061206161405.GV3927@implementation.labri.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> H. Peter Anvin, le Wed 06 Dec 2006 07:35:49 -0800, a écrit :
>> Samuel Thibault wrote:
>>>> The two can't be done at the same time.  In fact, the two probably can't 
>>>> be done without a period of quite a few *years* between them.
>>> Not a reason for not doing it ;)
>> No, but breakage is.  There has to be a major benefit to justify the 
>> cost, and you, at least, have not provided such a justification.
> 
> Well, as I said, existing code like
> 
> switch(errno) {
> 	case ENOTSUP:
> 		foo();
> 		break;
> 	case EOPNOTSUP:
> 		bar();
> 		break;
> }
> 

That's pretty weak, though.

	-hpa
