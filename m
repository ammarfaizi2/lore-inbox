Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWECNXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWECNXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWECNXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:23:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:65078 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030197AbWECNXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aFj8OB3c8tZQvcl71UMc79IB94lXkAjap0TB/FyPInwRyWWKhCM/T0zcBOWQII6SLGBFSOvL6pklMwx7ObhDe00smnaSQ/e4HXbzIg+v0TIdj8JtaMWlPMIJg2qdc2Cx0NJTYYTrpk9IVU5od5OJvw866h0HmeM5HwS6gDDBP4g=
Message-ID: <9e4733910605030623w7751ff43u6f1bb7835bf65e88@mail.gmail.com>
Date: Wed, 3 May 2006 09:23:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Dave Airlie" <airlied@gmail.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <4458475F.3010203@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
	 <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
	 <4458475F.3010203@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> Jon Smirl wrote:
> > On 5/2/06, Dave Airlie <airlied@gmail.com> wrote:
> >> Jon stop being so dramatic, this is just like letting userspace map
> >> the BARs, without ownership through sysfs, which is a good thing, you
> >> can still map /dev/mem, look we have lots of ways to shoot ourselves
> >> in the foot, if we *want* to.
> >
> > So why don't we just build a VGA class driver or make null fbdev
>
> I think your mail client is defective, you somehow managed to not attach the patch *again*.
>

Lack of a patch for a correct solution is no reason to put a bad
solution into the kernel.  GregKH has a lot to say about PCI class
drivers and he has commented on this thread yet. DaveA and I have both
attempt to do the correct fix both those attempts have fallen apart
main for political reasons.


--
Jon Smirl
jonsmirl@gmail.com
