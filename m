Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLARjf>; Sun, 1 Dec 2002 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSLARjf>; Sun, 1 Dec 2002 12:39:35 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:28945 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S262266AbSLARje>; Sun, 1 Dec 2002 12:39:34 -0500
Date: Mon, 2 Dec 2002 04:46:43 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Greg KH <greg@kroah.com>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       <linux-security-module@wirex.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LSM fix for stupid "empty" functions
In-Reply-To: <20021201181227.GC8829@kroah.com>
Message-ID: <Mutt.LNX.4.44.0212020441560.19785-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Greg KH wrote:

> On Sun, Dec 01, 2002 at 05:59:10PM +0100, Olaf Dietsche wrote:
> > >  	VERIFY_STRUCT(struct security_operations, ops, err);
> > 
> > This shouldn't be necessary anymore.
> 
> Good point, I'll remove it.  It was a hack anyway :)
> 

I think we still want to make sure that the module author has explicitly
accounted for all of the hooks, in case new hooks are added.


- James
-- 
James Morris
<jmorris@intercode.com.au>



