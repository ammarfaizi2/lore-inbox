Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGLLMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGLLMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGLLMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:12:37 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59423 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751252AbWGLLMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:12:36 -0400
Message-ID: <44B4D8CD.5090701@sw.ru>
Date: Wed, 12 Jul 2006 15:11:09 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <m164i3gad1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164i3gad1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't had a chance to do a thorough review yet but why is
> this needed?
> 
> What can be left shared by switching to a new namespace and then
> execing an executable?
> 
> Is it not possible to ensure what you are trying to ensure with
> a good user space executable?

I agree with Eric. In OpenVZ we don't do exec(), because executable itself ensures
correct environment.

Do we need to overcomplicate kernel in this regard?

Thanks,
Kirill

