Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWIXOef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWIXOef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWIXOef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:34:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:12911 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750981AbWIXOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cPGV2HFv4yTW8LQ0Ul5qL1WQqwbtgwvfh0kbV2ZZ99M0mp4xe4FWImXAeh/bIrEwZNzgzA8yJS7nDxKCnVCZTG2nZct9YAiEiNXmpyES68Eu0b719U6hv9aJ/rbfLJFJTMfwfJvpZAkiHl8fRYQuQpKCmAmogKwkBpZGniCA8hM=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: James Cloos <cloos@jhcloos.com>
Subject: Re: bzImage too big to boot???
Date: Sun, 24 Sep 2006 16:33:14 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <m37iztv6y1.fsf@lugabout.jhcloos.org>
In-Reply-To: <m37iztv6y1.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609241633.14250.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 September 2006 13:29, James Cloos wrote:
> I don't know whether this is a build-time issue or a grub issue, but
> I've found that on my (pent-3m) laptop I cannot boot any kernel that
> is larger than about 2500 K.  (2504K boots, 2552K fails.)
> 
> Past that threshold grub complains:  ERR_BAD_FILETYPE.
> 
> A 2504 K bzImage translates to a 6128 K vmlinux, 2552 K to 6252 K.
> 
> Should bzImages that large be bootable on x86?

Yes. I can boot 3MB bzImage with lilo and with linld,
although lilo seems to have some trouble with initrd
with kernel images that large.
--
vda
