Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTDXNuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTDXNuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:50:25 -0400
Received: from pointblue.com.pl ([62.89.73.6]:54546 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263658AbTDXNuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:50:24 -0400
Subject: Re: kernel ring buffer accessible by users
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051113589.707.948.camel@localhost>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
	 <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net>
	 <1051113589.707.948.camel@localhost>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1051192692.777.10.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 15:02:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 16:59, Robert Love wrote:
> On Wed, 2003-04-23 at 11:56, Werner Almesberger wrote:
> 
> > How do you know what is sensitive information ? A kernel debug
> > message may just say something like "bad message 47 65 68 65 69 6d",
> > and the kernel has no idea that this is actually a password
> 
> Why on earth would the user give the kernel a password?
> 
> The point is user input like telephone numbers or passwords should never
> be fed into the kernel anyhow.  On the rare case it is (apparently this
> ISDN instance, assuming it is actually from dmesg and not syslog), the
> kernel should not echo it.
Some will probably agree that this kind of information should be
optionaly ( option in kernel configuration ) restricted for non root
users. The same problem apply to /proc restrictions, that are available
with grsec only, but many will also agree that this should be option in
kernel. 
One of the security rules says that we should not give away information
that is not required for others. Fe. nobody should know (except
root/administrators) who is loged on or even what programs i am running.
This way i am able sometimes to see sensitive information that is passed
in command line (fe with wget).
   
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

