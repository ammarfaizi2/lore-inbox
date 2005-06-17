Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVFQOzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVFQOzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVFQOzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:55:41 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:7865 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261986AbVFQOze convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:55:34 -0400
X-IronPort-AV: i="3.93,208,1115010000"; 
   d="scan'208"; a="255552808:sNHT38802160"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Fri, 17 Jun 2005 09:55:31 -0500
Message-ID: <B37DF8F3777DDC4285FA831D366EB9E2073081@ausx3mps302.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Thread-Index: AcVypJgrox7RuEeIQeCIHdColVNzDQAp6uSQ
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <dmitry.torokhov@gmail.com>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 17 Jun 2005 14:55:31.0973 (UTC) FILETIME=[9BDF2B50:01C5734C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Thursday, June 16, 2005 1:52 PM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; Andrew Morton; Dmitry Torokhov;
Domsch,
> Matt
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
Dell
> BIOS update driver
> 
> On Wed, Jun 15, 2005 at 12:59:46PM -0500, Abhay Salunke wrote:
> > +static struct device rbu_device_mono;
> > +static struct device rbu_device_packet;
> > +static struct device rbu_device_cancel;
> 
> You should never create a struct device on the stack.  Lots of bad
> things can happen (including not having a release function for them.)
> 
they are not declared inside any function; can they be on stack?
> Why not just point to the cpu device, or some other platform or system
> device?
> 
Not sure what these devices are for and didn't want to mess with them.> 

Thanks
Abhay
