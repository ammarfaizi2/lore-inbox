Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWDLHBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWDLHBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 03:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWDLHBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 03:01:06 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:4833 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbWDLHBF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 03:01:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g7rdhGUSNFJcJhta+qef1RUpyzTitsgfy16sh+LRPwNwV0k3fpZC5LnU2LWWitOynp7+C/ttlJgOuV2L8pAEaS6diieOt8y7V5ucnY/XsL1TBxWr2GlBRlz2Ei+oQ9kYv18LAF8RxdJUo6HNHvnJkWFwLiKekA90ENRWKJuoaGs=
Message-ID: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
Date: Wed, 12 Apr 2006 00:01:02 -0700
From: "Pramod Srinivasan" <pramods@gmail.com>
To: "David Weinehall" <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Userspace code that uses interfaces that was not exposed to userspace
> before you change the kernel --> GPL (but don't do it; there's almost
> always a reason why an interface is not exported to userspace)

> 4. Userspace code that only uses existing interfaces --> choose
> license yourself (but of course, GPL would be nice...)

> 5. Userspace code that depends on interfaces you added to the kernel
> --> consult a lawyer (if this interface is something completely new,
> you can *probably* use your own license for the userland part; if the
> interface is more or less a wrapper of existing functionality, GPL)

An example could be helpful in clarifying the GPL license.

Suppose I use the linux-vrf patch for the kernel that is freely
available and use the extended setsocket options such as SO_VRF in an
application, do I have to release my application under GPL since I am
using a facility in the kernel that a standard linux kernel does not
provide?

Suppose my LKM driver adds a extra header to all outgoing packets and
removes the extra header from the incoming packets, should this driver
be released under GPL.? In a way it extends the functionality of
linux, if I do release the driver code under GPL because this was
built with linux  in mind, Should I release the application  which
adds intelligence to interpret the extra header under GPL?

Thanks,
Pramod
