Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVFHWel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVFHWel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVFHWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:34:40 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:49742 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262147AbVFHWea convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:34:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LbZPKSgfGAKBAh0S9pHg6AzqiOGOyVRSP0d9oZEwQm9xwT2npN9KCnvmfMPTf4t7C1NWJDKFgBdmv/3A3sK4pcGC86K97CER9MRozKELR1QwX01dFo/JjwPzq1pZAax0EyflNTddT2EEs8pTt2qpkHGCGHJYQmg9w8VX6/XNX6s=
Message-ID: <9e47339105060815343eaa6c31@mail.gmail.com>
Date: Wed, 8 Jun 2005 18:34:24 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: Dell BIOS and HPET timer support
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050608220214.GE21704@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105060813115d01282@mail.gmail.com>
	 <20050608220214.GE21704@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Matt Domsch <Matt_Domsch@dell.com> wrote:
> On Wed, Jun 08, 2005 at 04:11:39PM -0400, Jon Smirl wrote:
> > After several communications with Dell support I have determined that
> > most Dell BIOSs don't include the ACPI entry for the HPET timer. The
> > official reason for this is that no version of Windows uses the HPET
> > and adding the ACPI entry might cause compatibility problems.
> 
> What platform/BIOS version please?  PowerEdge x8xx servers certainly
> do have HPET enabled in their ACPI tables.

All Dell PE400SC, Dim8300, Precision360 for sure. From my talk with
them none of the desktops have it enabled. They acknowledge that it is
on for some server boxes but not for most other systems.

-- 
Jon Smirl
jonsmirl@gmail.com
