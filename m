Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSGKAwl>; Wed, 10 Jul 2002 20:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSGKAwk>; Wed, 10 Jul 2002 20:52:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:29190 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317693AbSGKAwj>;
	Wed, 10 Jul 2002 20:52:39 -0400
Date: Wed, 10 Jul 2002 17:52:36 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020711005236.GA2587@kroah.com>
References: <20020711001549.D17806@flint.arm.linux.org.uk> <E17SRB0-00086D-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SRB0-00086D-00@the-village.bc.nu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 12 Jun 2002 23:43:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 12:47:18AM +0100, Alan Cox wrote:
> > What about /proc/sys/cpu/<number>/<datapoint> ?
> 
> What happens if the cpus are hot plugged and change ID while doing the
> config 8)

<driverfs_mount>/root/cpu/<number>/<datapoint>

That can handle dynamic data just fine :)

greg k-h
