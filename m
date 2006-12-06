Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935845AbWLFP1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935845AbWLFP1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935858AbWLFP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:27:33 -0500
Received: from terminus.zytor.com ([192.83.249.54]:34285 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935845AbWLFP1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:27:32 -0500
Message-ID: <4576E134.5020109@zytor.com>
Date: Wed, 06 Dec 2006 07:26:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <4576DED7.10800@zytor.com> <20061206152542.GS3927@implementation.labri.fr>
In-Reply-To: <20061206152542.GS3927@implementation.labri.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> H. Peter Anvin, le Wed 06 Dec 2006 07:16:39 -0800, a écrit :
>> Arjan van de Ven wrote:
>>>> Is there any way to fix this?  Glibc people don't seem to want to fix it
>>>> on their part, see
>>>> http://sources.redhat.com/bugzilla/show_bug.cgi?id=2363
>>> Hi,
>>>
>>> Ulrich asked you to go to us once your time travel machine was
>>> finished.. is it finished yet ?  ;=)
>>>
>>> this is part of the ABI, so we can't change this in 2006...
>>>
>> If ENOTSUP is currently unused and is only there for completeness, then 
>> it should be fine to add it.
> 
> The functions that should be returning it instead of EOPNOTSUP should be
> fixed too.
> 

The two can't be done at the same time.  In fact, the two probably can't 
be done without a period of quite a few *years* between them.

	-hpa
