Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVJERnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVJERnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVJERnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:43:35 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:63429 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030288AbVJERne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:43:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=j0zctnyq9qVRE2yvv7WInsHzbahPwigQHGL6jnUDma1KXNMKBJlv5Od6JJ6JtM80HQXBCNiWlbws0wW6zDHYjDb4QiJyfmVJ+6mncAJH2MhM8nge2g/KLAuOqO3oPJf+V94fFV5VsAfI302UiyzfxhonE0ltgGiL3ZMXsLYrURs=
Subject: Re: Kernel Panic Error in 2.6.10 !!!!
From: Badari Pulavarty <pbadari@gmail.com>
To: umesh chandak <chandak_pict@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051005173534.32907.qmail@web35908.mail.mud.yahoo.com>
References: <20051005173534.32907.qmail@web35908.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:42:56 -0700
Message-Id: <1128534181.4754.68.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 10:35 -0700, umesh chandak wrote:
> hi,
>          I have compiled the kernel 2.6.10 with KGDB
> patches on FC3 .My KGDB connetion are made correct .
> I have copied bzImage and System.map on test machine .
> but when i press C for continuig no devlopment m/c
> after  connection are made.It gives me kernel panic
> error like this 
> 
> VFS: Cannot open root device "hda6" or
> unknown-block(3,6)
> Please append a correct "root=" boot option Kernel
> panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(3,6)

You might need initrd or make sure "ide" is configured
in your kernel.

Thanks,
Badari

