Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSHPEcK>; Fri, 16 Aug 2002 00:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSHPEcJ>; Fri, 16 Aug 2002 00:32:09 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:38919 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318132AbSHPEcJ>;
	Fri, 16 Aug 2002 00:32:09 -0400
Date: Thu, 15 Aug 2002 21:31:40 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
Message-ID: <20020816043140.GA2478@kroah.com>
References: <3D5C6410.1020706@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5C6410.1020706@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 19 Jul 2002 03:27:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 07:31:44PM -0700, Dave Hansen wrote:
> Not _another_ proc entry!

Yes, not another one.  Why not move these to driverfs, where they
belong.

(ignore the driverfs name, it should be called kfs, or some such thing,
as stuff more than driver info should go there, just like these entries.)

thanks,

greg k-h
