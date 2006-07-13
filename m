Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWGMQN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWGMQN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWGMQN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:13:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:6037 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932452AbWGMQN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:13:57 -0400
Message-ID: <44B6713E.9080109@fr.ibm.com>
Date: Thu, 13 Jul 2006 18:13:50 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>	<m164i3gad1.fsf@ebiederm.dsl.xmission.com>	<44B41803.8040900@fr.ibm.com>	<m1odvvec9s.fsf@ebiederm.dsl.xmission.com> <44B4F3AE.60607@fr.ibm.com> <m11wsqbw49.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wsqbw49.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113881171017330&w=2
> 
> That message is a terrible example.  Unless you are thinking of something
> farther down that thread.  User space getting confused when it creates
> a container is just an implementation of the container creation code.
>
> Now I'm not certain what you mean by a clean process image, as there are always
> left over pieces from the parent.  Clone creates a new task_struct.  exec replaces
> the executable.  They both keep files open.

next week, we need to work on that topic : how to assemble namespaces to
create a container. I'm sure this will cut down the email volume due to
confusion.

thanks,

C.
