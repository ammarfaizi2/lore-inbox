Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVD1E6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVD1E6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 00:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVD1E6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 00:58:05 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:58314 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261963AbVD1E5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 00:57:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pVjzU3JODBe4BRJRxznjTTXKUgvcFE6sxXDHvm7aA+9RSVfFNmbmwzsa87asdH3FcFd3YJg+zQ7obhZvddbDGJrl/h8KsWLS0HfaHV/Z8Cnpy/RcsGFnlXFRway0KWbbpLRFp/Thji09BNsDlzxfbPLSsPZ4g9T9PqW7haDx7+g=
Message-ID: <d4757e6005042721577ba48cc@mail.gmail.com>
Date: Thu, 28 Apr 2005 00:57:46 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Device Node Issues with recent mm's and udev
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050428041428.GB9723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005042716523af66bae@mail.gmail.com>
	 <20050428041428.GB9723@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Greg KH <greg@kroah.com> wrote:
> Is the device "disappearing" and then the udev deletes the device node,
> and then dd starts dumping data to a file instead?
> 
> Anything in your kernel log when this happens?
> 
> Does this happen with 2.6.12-rc3?
> 
> thanks,
> 
> greg k-h
> 

I've checked the kernel logs and was unable to find anything
suspicious.  This does not seem to happen on vanilla, its a mm only
issue.

The device becomes a regular file, and udev seems to forget about it..
even if I replug in the device, udev will not touch this file.  It
also seems to have trouble recreating the node even when the file has
been deleted

Hope that helps, 

Joe
