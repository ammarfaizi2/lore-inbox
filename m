Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291989AbSB0EXd>; Tue, 26 Feb 2002 23:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292005AbSB0EXW>; Tue, 26 Feb 2002 23:23:22 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48651 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291989AbSB0EXI>;
	Tue, 26 Feb 2002 23:23:08 -0500
Date: Tue, 26 Feb 2002 20:16:41 -0800
From: Greg KH <greg@kroah.com>
To: Shane Nay <shane@minirl.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@sii.li
Subject: Re: Simple cyberjack diff
Message-ID: <20020227041641.GG3353@kroah.com>
In-Reply-To: <20020226211128Z292609-889+7550@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020226211128Z292609-889+7550@vger.kernel.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 30 Jan 2002 01:30:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 02:16:35PM -0800, Shane Nay wrote:
> While looking around the usb code I noticed this semaphore problem in
> cyberjack.  Anyway, it's a quicky.

Good catch.  I'll add it to my 2.4 and 2.5 trees and push the changes
onward.

The same problem is also in the copy_from_user() test a few lines below
this one.  I'll fix it.

thanks again,

greg k-h
