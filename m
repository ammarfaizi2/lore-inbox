Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTIMDAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 23:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTIMDAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 23:00:11 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:35437 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262005AbTIMC7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:59:12 -0400
Message-ID: <3F62881B.3060806@sbcglobal.net>
Date: Fri, 12 Sep 2003 21:59:39 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Longland <stuartl@longlandclan.hopto.org>
CC: iain d broadfoot <ibroadfo@cis.strath.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: getting a working CD-drive in 2.6
References: <20030912093837.GC2921@iain-vaio-fx405> <3F627C13.6020608@longlandclan.hopto.org>
In-Reply-To: <3F627C13.6020608@longlandclan.hopto.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stuart Longland wrote:

> iain d broadfoot wrote:
>
> |     ide-scsi is disabled.
>
> If it's an IDE drive, you'll want this _enabled_ before you'll be able
> to write CDs.  Most of the burner software that I know of look for a
> SCSI CD burner, not IDE.  ide-scsi is intended for making an IDE CD
> burner appear as a SCSI device.


Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade 
your cdrecord tools and probably your burning GUI, if you use one.  I've 
been burning that way for several months now.  (I'm using xcdroast, 
though I need to start it with "-n" since I'm using cdrecord 2.01a18.)  
This actually works better for me than ide-scsi as for some reason it 
uses less CPU.

-Wes-

