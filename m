Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTLIJng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTLIJne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:43:34 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:16887 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264269AbTLIJm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:42:58 -0500
Message-ID: <3FD5990A.9020908@google.com>
Date: Tue, 09 Dec 2003 01:42:34 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: ACPI global lock macros
References: <3FD59441.2000202@google.com> <1070962573.5223.2.camel@laptop.fenrus.com>
In-Reply-To: <1070962573.5223.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> maybe the odd thing is that it exists at all?
> (eg why does ACPI need to have it's own locking primitives...)

Because the ACPI spec defines its own locking protocol for 
synchronization between the OS and the BIOS.

Paul

