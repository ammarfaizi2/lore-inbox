Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJVXtS>; Tue, 22 Oct 2002 19:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJVXtS>; Tue, 22 Oct 2002 19:49:18 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22028 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262365AbSJVXtR>;
	Tue, 22 Oct 2002 19:49:17 -0400
Date: Tue, 22 Oct 2002 16:54:09 -0700
From: Greg KH <greg@kroah.com>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021022235409.GC9498@kroah.com>
References: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:09:38AM +0100, Richard J Moore wrote:
> We created
> kernel hooks for exactly the same reasons that LSM needs hooks - to allow
> ancillary function to exist outside the kernel, to avoid kernel bloat, to
> allow more than one function to be called from a given call-back (think of
> kdb and kprobes - both need to be called from do_debug).

No, that is NOT the same reason LSM needs hooks!  LSM hooks are there to
mediate access to various kernel objects, from within the kernel itself.
Please do not confuse LSM with any of the above projects.

thanks,

greg k-h
