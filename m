Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWEBRNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWEBRNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWEBRNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:13:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:19101 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964899AbWEBRND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:13:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JveTCLosvl21PaYUq5qhq0xBTQT4G5A7QrfcSwniPImGgtm6U3JdIqwql0CFAz9xMphBfZQCofeLVsXpTHZGgMLUZWMt3+90mgAtdTTR9sXPHy1CQ8Zhk0MCNjCpLX4hpd4l3lxQ7cc43aNF2gRLKhHv2RbE4g70/uXHaR1xaH8=
Message-ID: <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
Date: Tue, 2 May 2006 13:13:02 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
In-Reply-To: <44579028.1020201@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> Jon Smirl wrote:
> > All of these have been proposed before.
>
> I think you forgot to attach the patch
>
> > In my opinion an 'enable'
> > attribute is the worst solution in the bunch.
>
> you again limit yourself to VGA. I don't.

Haven't we learned that mucking with hardware from user space without
having a device driver loaded is a very bad idea.  What is the
motivation for providing an API whose only purpose is to enable this
bad behavior?


--
Jon Smirl
jonsmirl@gmail.com
