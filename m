Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUAOPkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUAOPkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:40:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39839 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264405AbUAOPkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:40:42 -0500
Date: Thu, 15 Jan 2004 15:40:39 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
Message-ID: <20040115154039.GG21151@parcelfarce.linux.theplanet.co.uk>
References: <1074177405.3131.10.camel@oebilgen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074177405.3131.10.camel@oebilgen>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 04:36:45PM +0200, Ozan Eren Bilgen wrote:
> Hi,
> 
> Today I downloaded 2.6.1 kernel and tried to configure it with "make
> gconfig". After all changes I selected "Save As" and clicked "/root"
> folder to save in. Then I clicked "OK", without giving a file name. I
> expected that it opens root folder and lists contents. But this magic
> configurator removed (rm -Rf) my root folder and created a file named
> "root". It was a terrible experience!..
> 
> Please fix this. I didn't check that same problem (I even didn't launch
> them) exist for other configurators then gconfig.
> 
> I send this mail here because I guessed that the configurator is a part
> of kernel.

*ugh*

gconfig behaviour aside, why on the earth are you running GUI code (_any_
GUI code) as root?
