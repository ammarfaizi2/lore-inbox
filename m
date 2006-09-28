Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWI1Vja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWI1Vja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWI1Vja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:39:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:869 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932199AbWI1Vj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:39:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V6AooZvUu2ejS185K1V5YN+y7dR0R3KeQICAVOh4T9TDy3GecbALT/3dzJRHcNXQ8vvruwxMCIkwh1sMe6Iar9UYvjddoiVHOOXQ68F45wSWdWmh/SZsGFuUE+xxT/WrN2gBNuJ8XmN7UKjDhpqNQX6XNDlWAroSTYfH4wKI8pI=
Message-ID: <5bdc1c8b0609281439h8e7a320j172727d39f758459@mail.gmail.com>
Date: Thu, 28 Sep 2006 14:39:27 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: Luke-Jr <luke@dashjr.org>
Subject: Re: PCI bridge missing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609281624.16082.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609281624.16082.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Luke-Jr <luke@dashjr.org> wrote:
> This applies to Debian sarge kernels kernel-image-2.4.27-2-686, 2.6.8-3-686,
> 2.6.16-2-686, and 2.6.17-2-686...
> I am trying to setup a Dell Optiplex GX1p system, which has a daughterboard
> PCI bridge for its PCI and ISA slots:
> 00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
>
> However, this bridge is completely ignored and unseen by Linux. It does not
> show up in lspci or dmesg (as far as I can tell) at all. The daughterboard is
> plugged in, and the PCI cards on it are powered.
>
> How could I go about troubleshooting the problem? Has anyone experienced
> something like this before?
>
> Thanks,
>
> Luke-Jr
>

Hi Luke,
   I have one machine with a PCI Bridge problem. This machine has PCI
TV cards behind a bridge. The cards are never recognized on a warm
boot but they are always found when the machine is cold booted. Go
figure.

   Anyway, maybe you haven't cold booted the machine and could try that?

- Mark
