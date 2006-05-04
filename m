Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWEDWFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWEDWFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWEDWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:05:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:34468 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030281AbWEDWFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:05:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F46zYsbKu4oloEjKkCHEkb2GSMUj6sU0LT7g9KuSAAt2NsMVeesVKthCrUhK5VueNCiCluctG1UjV1wAackgT7mf4uwlE/1pi+Y6QOYcQia8NO6SjFMujmJdJEWXDYb2pieVnqqJDLO985gJG2aFfCVfcbQUKu2Ot/ZrrEOLc7M=
Message-ID: <9e4733910605041505x69a6637fn1d32151fb63ef5a3@mail.gmail.com>
Date: Thu, 4 May 2006 18:05:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Peter Jones" <pjones@redhat.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1146779821.27727.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
	 <1146778720.27727.35.camel@localhost.localdomain>
	 <9e4733910605041448j431266d5x8669f79bd1b36e18@mail.gmail.com>
	 <1146779821.27727.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Peter Jones <pjones@redhat.com> wrote:
> On Thu, 2006-05-04 at 17:48 -0400, Jon Smirl wrote:
>
> > Let me be clear here. A lot of laptop video hardware does not have a
> > video ROM.
>
> Why do you assume we're only talking about laptops?

Because when you make statements like...
> Except to enable the BAR and read it from the assigned address...

That statement doesn't hold true for laptops. It indicates that you
may not be aware of all of the issues around VGA bus routing and video
ROMs. For example there are a lot of special issues with VGA support
in large large machines like the SGI Altix that have multiple
independent PCI domains. Owners of all of these other architectures
(PPC especially) having been beating me up for two years making me
aware of all of their weird cases.


>
> --
>   Peter
>
>


--
Jon Smirl
jonsmirl@gmail.com
