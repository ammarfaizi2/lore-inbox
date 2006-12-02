Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162466AbWLBUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162466AbWLBUrW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162467AbWLBUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:47:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:47583 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162466AbWLBUrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:47:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QaWVxUCLQkcv93RwSdhLyoXEacqZKny2+mhJ1vb9Un8XREGnNUyKSxOR00n3J3qQ1HiMILM+oaWyhSB6IkDT+ScsD1tIxlVZsnY263YNq3BVGel/3Nw+44JctRwoItv5Dr7tRLL64DCRrVsJc8Cba18NWkQfk4lN7bOsjup9zAw=
Message-ID: <2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com>
Date: Sat, 2 Dec 2006 12:47:18 -0800
From: yhlu <yinghailu@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org
In-Reply-To: <m1irgufl9q.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
	 <m1irgufl9q.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Please yank the direct out of the filename if you are making something
> like this out of it.  That was my note I was going direct to hardware
> which is pretty much assumed if you are in LinuxBIOS.

Yes, I adapted the code to used in LinuxBIOS, including CAR stage code
and RAM satge code.

I didn't have debug cable plugged yet.

BTW in kernel earlyprintk or prink, you could use
read_pci_config/write_pci_config before PCI system is loaded.

YH
