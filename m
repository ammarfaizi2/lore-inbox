Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTCYViz>; Tue, 25 Mar 2003 16:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTCYViz>; Tue, 25 Mar 2003 16:38:55 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:33785 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S261357AbTCYViy>; Tue, 25 Mar 2003 16:38:54 -0500
Date: Tue, 25 Mar 2003 14:50:51 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Greg KH <greg@kroah.com>
Cc: Deepak Saxena <dsaxena@mvista.com>, Jan Dittmer <j.dittmer@portrix.net>,
       sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: add eeprom i2c driver
Message-ID: <20030325215051.GA25641@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <20030325212753.GA21498@xanadu.az.mvista.com> <20030325213206.GD17249@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325213206.GD17249@kroah.com>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 25 2003, at 13:32, Greg KH was caught saying:
> > From my experience in seeing I2C eeproms on embedded systems, most 
> > people end up writing a custom little driver that does just what I 
> > said above: read/write/llseek. The eeprom driver should export the data
> > for each eeprom through /dev/eeprom interfaces This also allows for someone
> > to add a driver for larger EEPROMs (I have 512byte eeproms on some embedded 
> > boards) w/o having to add even more entries to sysfs for the remaining data.
> 
> I think the "one binary file" will work for all of your varied systems,
> right?

Yes. :)

Thanks,
~Deepak

> thanks,
> 
> greg k-h
> 

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

