Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUIGQlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUIGQlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGQjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:39:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4771 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268177AbUIGQh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:37:56 -0400
Date: Tue, 7 Sep 2004 12:37:48 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Greg KH <greg@kroah.com>
cc: Andreas Happe <andreashappe@flatline.ath.cx>,
       <linux-kernel@vger.kernel.org>, <cryptoapi@lists.logix.cz>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040906000446.GA16840@kroah.com>
Message-ID: <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Greg KH wrote:

> Other than that, I like this move, /proc/crypto isn't the best thing to
> have in a proc filesystem :)

The only issue is what to do about potentially expanding this into an API 
(e.g. open() an algorithm and write to it).  Does this sort of thing 
belong in sysfs?


- James
-- 
James Morris
<jmorris@redhat.com>


