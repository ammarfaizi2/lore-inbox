Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268847AbTBZRgE>; Wed, 26 Feb 2003 12:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268848AbTBZRgE>; Wed, 26 Feb 2003 12:36:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36100 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268847AbTBZRgD>;
	Wed, 26 Feb 2003 12:36:03 -0500
Date: Wed, 26 Feb 2003 09:38:05 -0800
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] dm: allow slashes in dm device names
Message-ID: <20030226173804.GA16095@kroah.com>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171157.GF8369@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226171157.GF8369@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 05:11:57PM +0000, Joe Thornber wrote:
> Allow slashes ('/') within a DM device name, but not at the beginning.
> 
> Devfs will automatically create all necessary sub-directories if a name
> with embedded slashes is registered.  [Kevin Corry]

Does this interact with the block device name representation in sysfs?
I don't think sysfs can handle names with '/' very well.

thanks,

greg k-h
