Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWGLNKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWGLNKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGLNKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:10:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6565 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750977AbWGLNKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:10:41 -0400
Message-ID: <44B4F4CA.7070106@fr.ibm.com>
Date: Wed, 12 Jul 2006 15:10:34 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <m164i3gad1.fsf@ebiederm.dsl.xmission.com> <44B4D8CD.5090701@sw.ru>
In-Reply-To: <44B4D8CD.5090701@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Kirill Korotaev wrote:
>> I haven't had a chance to do a thorough review yet but why is
>> this needed?
>>
>> What can be left shared by switching to a new namespace and then
>> execing an executable?
>>
>> Is it not possible to ensure what you are trying to ensure with
>> a good user space executable?
> 
> I agree with Eric. In OpenVZ we don't do exec(), because executable
> itself ensures correct environment.

Could briefly explain how the first process is started in a VPS ? Sorry for
being lazy and not looking at the code, but it would be interesting for all
to have some info.

> Do we need to overcomplicate kernel in this regard ?

I don't think it's an amazing kernel overkill. Just an extension to exec
with some flags to set up the environement in which the exec will be done.
there might another way to do it.

thanks,

C.
