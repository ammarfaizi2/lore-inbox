Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWDLCi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWDLCi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 22:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWDLCi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 22:38:27 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:17886 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751321AbWDLCi0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 22:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BseIkOGY0Z3TjGrRWFCORGBcONNRKG1YQ8RFUWxUG7Rih8OfBCCNHGhkFXigc2X2+BVp3590NMQ1UfTHFCdkjPZRa/3GcQFJCmI06KkkxoLPhsm433sZhjnZgk4Z+0ISl5kYJNMMK8Rnf0mUGaayAeLmbp8GnuECvwbFtz51UWg=
Message-ID: <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
Date: Tue, 11 Apr 2006 19:38:24 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Ramakanth Gunuganti" <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
In-Reply-To: <20060411230642.GV23222@vasa.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
	 <20060411230642.GV23222@vasa.acc.umu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
> OK, simplified rules; if you follow them you should generally be OK:
>
> 1. Changes to kernel --> GPL
>
> 2. Kernel driver --> GPL
>
> 3. Userspace code that uses interfaces that was not exposed to userspace
> before you change the kernel --> GPL (but don't do it; there's almost
> always a reason why an interface is not exported to userspace)
>
> 4. Userspace code that only uses existing interfaces --> choose
> license yourself (but of course, GPL would be nice...)
>
> 5. Userspace code that depends on interfaces you added to the kernel
> --> consult a lawyer (if this interface is something completely new,
> you can *probably* use your own license for the userland part; if the
> interface is more or less a wrapper of existing functionality, GPL)
>
> And of course, I'm not a lawyer either...
Excellent summary except for one case. Propriatary binary allowed in initramfs?
Not that I care.
