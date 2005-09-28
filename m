Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVI1JS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVI1JS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVI1JS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:18:28 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:47636 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030229AbVI1JS1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:18:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y5jA7jhtWPQqVk6VdufI6q7LMRsk9CrHfC70X/rWDvaKdYFlV/uoHtDgGA9rVRbmdBXSNudaVVSGeMCMGB2G+6RgT9R1I9LEN4spnXElJw/DmbS9f//aDI+eHf/SCh4UV8igs2hw0QbB4ZjeKly1PjVLWGA31jNt7IIUtbLnoGU=
Message-ID: <b115cb5f050928021835306f16@mail.gmail.com>
Date: Wed, 28 Sep 2005 18:18:22 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Jason Baron <jbaron@redhat.com>
Subject: Re: Problem booting 2.6.13 on RHEL 4
Cc: Linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509151124420.15025@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f05091321082a3ffc24@mail.gmail.com>
	 <Pine.LNX.4.61.0509151124420.15025@dhcp83-105.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Wed, 14 Sep 2005, Rajat Jain wrote:
>
> > Hi list,
> >
> > I am using RHEL4 distribution, and am trying to boot with vanilla
> > 2.6.13 stock kernel. My system has two onboard Adaptec SCSI
> > controllers. I am booting using initrd, and passing the correct
> > "root=" option. The following message pops up while trying to boot
> > with 2.6.13:
> >
>
> it might be worth trying an updated 'mkinitrd'. The one currently in rhel4
> can currently do parallel 'insmod's, which might be causing this issue.
> See bugzilla: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=145660
> for more detail. This is fixed in U2, which isn't quite shipping yet, but
> in the meantime, I think you can get the updated package from the U2 beta
> channel.

Hi Jason,

Thanks a TON! I was truggling with mkinitrd and nash for the past 3
weeks, and finally a *very* odd combination of mkinitrd and nash
solved the problem. But thanks for your inputs, they've been really
helpful.

Rajat
